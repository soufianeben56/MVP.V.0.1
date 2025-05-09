import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:infinity_circuit/constants/ble_constants.dart';
import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/models/network/response_models/bluetooth_service_response.dart';
import 'package:infinity_circuit/service/routing/arguments/device_list_arguments.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceListViewModel extends LocalBaseModel {
  List<DeviceListArguments> deviceList = [];

  bool isFromRefresh = false;

  ///
  @override
  void onInit() {
    super.onInit();
    FlutterBluePlus.stopScan();
  }

  onTapRefreshScan() async {
    isFromRefresh = true;
    deviceList.clear(); // Clear the list when refresh is tapped
    notifyListeners();
    await startScanDevice();
  }

  Future<void> startScanDevice() async {
    await deviceDisConnect();
    // Check and request necessary permissions
    await requestPermissions();

    // Ensure Bluetooth is enabled before scanning
    var bluetoothState = await FlutterBluePlus.adapterState.first;

    if (Platform.isAndroid) {
      // Android: Handle turning Bluetooth on if it is off
      if (bluetoothState == BluetoothAdapterState.off) {
        print('Bluetooth is turned off, turning it on...');
        await FlutterBluePlus.turnOn();
        bluetoothState = await FlutterBluePlus.adapterState.first;
      }
    } else if (Platform.isIOS) {
      // iOS: Notify the user that they need to turn on Bluetooth manually
      if (bluetoothState == BluetoothAdapterState.off) {
        print(
            'Bluetooth is turned off. Please turn on Bluetooth in your device settings.');
        return; // Exit the function as we cannot turn Bluetooth on programmatically
      }
    }

    if (bluetoothState == BluetoothAdapterState.on) {
      // Create a list to store scan results during the scan session
      deviceList.clear();

      // Start scanning
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Listen to scan results and add them to the deviceList
      FlutterBluePlus.scanResults.listen((results) async {
        if (results.isNotEmpty) {
          for (ScanResult r in results) {
            // Get the device name or assign 'Unknown Device' if the name is empty
            String deviceName =
                r.device.name.isNotEmpty ? r.device.name : 'Unknown Device';

            // Create an instance of DeviceListArguments for the scanned device
            DeviceListArguments deviceArguments = DeviceListArguments(
              title: deviceName,
              deviceId: r.device.remoteId.toString(),
              customValue: r.rssi, // RSSI (signal strength)
            );

            // Check if the device name contains 'RLC' (case-insensitive)
            if (deviceArguments.title
                    .toLowerCase()
                    .contains("rlc".toLowerCase()) &&
                !deviceList.any(
                    (device) => device.deviceId == deviceArguments.deviceId)) {
              // Add the device to the list if it matches the condition and is not already added
              deviceList.add(deviceArguments);
              notifyListeners();
              print('Devices with "RLC" found: ${deviceList.last.customValue}');
              await FlutterBluePlus.stopScan();
            }
          }

          // After processing all devices, handle the list if needed
          if (deviceList.isNotEmpty) {
            notifyListeners();

            // print('Devices with "RLC" found: ${deviceList.length}');
            // You can navigate or handle the list here
          }
        } else {
          print('No devices found.');
        }
      });
    } else {
      print('Failed to turn on Bluetooth.');
    }
  }

  /// Requests necessary Bluetooth and location permissions
  Future<void> requestPermissions() async {
    // Request Bluetooth permissions for Android 12+ (API level 31+)
    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }
    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }
    // Request location permission (required by many Android versions for BLE scanning)
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  ///
  Future<List<BluetoothServiceResponse>> connectAndDiscoverServices(
      String deviceInfo) async {
    final device = BluetoothDevice.fromId(deviceInfo);

    try {
      String? deviceId = UserPreference.getString(PrefKeys.deviceId);
      log("deviceId =====> $deviceId");

      await device.connect();
    } catch (e) {
      log("Connection error: $e");
      return []; // Return an empty list if connection fails
    }

    // Discover services
    var services = await device.discoverServices();
    log("services =====> $services");

    // Map the discovered services to your BluetoothServiceResponse model
    List<BluetoothServiceResponse> bluetoothServiceResponses =
        services.map((service) {
      return BluetoothServiceResponse(
        remoteId: device.id.toString(),
        serviceUuid: service.uuid.toString(),
        isPrimary: service.isPrimary,
        characteristics: service.characteristics.map((characteristic) {
          // Convert BluetoothCharacteristic to BluetoothCharacteristicResponse
          return BluetoothCharacteristicResponse(
            remoteId: device.id.toString(),
            serviceUuid: service.uuid.toString(),
            characteristicUuid: characteristic.uuid.toString(),
            descriptors: characteristic.descriptors.map((descriptor) {
              // Convert BluetoothDescriptor to BluetoothDescriptorResponse (if needed)
              return BluetoothDescriptorResponse(
                descriptorUuid: descriptor.uuid.toString(),
                lastValue: descriptor.lastValue.toString(),
              );
            }).toList(),
            properties: CharacteristicPropertiesResponse(
              read: characteristic.properties.read,
              write: characteristic.properties.write,
              notify: characteristic.properties.notify,
              indicate: characteristic.properties.indicate,
            ),
          );
        }).toList(),
        includedServices: service.includedServices.map((includedService) {
          // Convert included services to BluetoothServiceResponse recursively
          return BluetoothServiceResponse(
            remoteId: device.id.toString(),
            serviceUuid: includedService.uuid.toString(),
            isPrimary: includedService.isPrimary,
            characteristics:
                includedService.characteristics.map((includedCharacteristic) {
              return BluetoothCharacteristicResponse(
                remoteId: device.id.toString(),
                serviceUuid: includedService.uuid.toString(),
                characteristicUuid: includedCharacteristic.uuid.toString(),
                descriptors:
                    includedCharacteristic.descriptors.map((descriptor) {
                  return BluetoothDescriptorResponse(
                    descriptorUuid: descriptor.uuid.toString(),
                    lastValue: descriptor.lastValue.toString(),
                  );
                }).toList(),
                properties: CharacteristicPropertiesResponse(
                  read: includedCharacteristic.properties.read,
                  write: includedCharacteristic.properties.write,
                  notify: includedCharacteristic.properties.notify,
                  indicate: includedCharacteristic.properties.indicate,
                ),
              );
            }).toList(),
            includedServices: [], // Include nested services if required
          );
        }).toList(),
      );
    }).toList();

    // Save the data to UserPreferences
    await UserPreference.putObjectList(
      PrefKeys.bluetoothServices,
      bluetoothServiceResponses.map((service) => service.toJson()).toList(),
    );

    isDeviceConnected = true;
    redirectWithClearBackStack(RoutePaths.homeViewRoute);

    return bluetoothServiceResponses;
  }

  Future<void> deviceDisConnect() async {
    String? deviceId = UserPreference.getString(PrefKeys.deviceId);

    final device = BluetoothDevice.fromId(deviceId!);
    try {
      String? deviceId = UserPreference.getString(PrefKeys.deviceId);
      log("deviceId =====> $deviceId");

      await device.disconnect();
    } catch (e) {
      log("Connection error: $e");
    }
  }
}
