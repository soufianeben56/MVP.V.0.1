import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../exports.dart';
import '../../../service/routing/arguments/device_list_arguments.dart';

class ScanDeviceViewModel extends LocalBaseModel {
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  DeviceListArguments? deviceArguments;

  ScanDeviceViewModel();

  /// Requests Bluetooth permissions and starts the Bluetooth operations
  Future<void> startBluetoothOperations({
    List<Guid> withServices = const [],
    List<String> withRemoteIds = const [],
    List<ServiceDataFilter> withServiceData = const [],
    Duration? timeout,
  }) async {
    // Request Bluetooth permissions
    await requestBluetoothPermissions();

    // Turn on Bluetooth if necessary and scan devices
    if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.off) {
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
        await checkBluetoothConnection();
      } else {
        await openAppSettings();
      }
    }

    if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on) {
      startDeviceScan(
        withServices: withServices,
        withRemoteIds: withRemoteIds,
        withServiceData: withServiceData,
        timeout: timeout,
      );
    }
  }

  Future<void> requestBluetoothPermissions() async {
    // Example using the permission_handler package:
    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }

    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }

    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  Future<void> checkBluetoothConnection() async {
    var state = await FlutterBluePlus.adapterState.first;
    notifyListeners();
  }

  /// Start scanning for devices
  Future<void> startDeviceScan({
    List<Guid> withServices = const [],
    List<String> withRemoteIds = const [],
    List<ServiceDataFilter> withServiceData = const [],
    Duration? timeout,
  }) async {
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
    }

    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();

    await FlutterBluePlus.startScan(
      withServices: [], // match any of the specified services
      withNames: ["RLC"], // *or* any of the specified names
      timeout: Duration(seconds: 15),
      continuousUpdates: false,
      removeIfGone: const Duration(seconds: 10),
    );

    notifyListeners(); // Update UI with scanning results
  }

  Future<void> stopDeviceScan() async {
    await FlutterBluePlus.stopScan();
  }

  @override
  void onInit() {
    startScanDevice();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    stopDeviceScan();
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
      List<DeviceListArguments> deviceList = [];
      deviceList.clear();

      log("bluetoothState : $bluetoothState");
      // Start scanning
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

      // Listen to scan results and add them to the deviceList
      FlutterBluePlus.scanResults.listen((results) async {
        if (results.isNotEmpty) {
          for (ScanResult r in results) {
            // Get the device name or assign 'Unknown Device' if the name is empty
            String deviceName = r.device.platformName.isNotEmpty
                ? r.device.platformName
                : 'Unknown Device';

            // Create an instance of DeviceListArguments for the scanned device
            DeviceListArguments deviceArguments = DeviceListArguments(
              title: deviceName,
              deviceId: r.device.remoteId.toString(),
              customValue: r.rssi, // RSSI (signal strength)
            );

            log("ScasnDevice: ${deviceArguments.title}");

            // Check if the device name contains 'RLC' (case-insensitive)
            if (deviceArguments.title
                    .toLowerCase()
                    .contains("rlc".toLowerCase()) &&
                !deviceList.any(
                    (device) => device.deviceId == deviceArguments.deviceId)) {
              // Add the device to the list if it matches the condition and is not already added
              deviceList.add(deviceArguments);
              await FlutterBluePlus.stopScan();
              await Future.delayed(const Duration(seconds: 5));

              redirectWithPop(RoutePaths.deviceListView, arguments: deviceList);

              print('Devices with "RLC" found: ${deviceList.last.customValue}');
            }
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

  Future<void> deviceDisConnect() async {
    String? deviceId = UserPreference.getString(PrefKeys.deviceId);

    await connectAndDiscoverServices(deviceId!);
  }

  Future<void> connectAndDiscoverServices(String deviceInfo) async {
    final device = BluetoothDevice.fromId(deviceInfo);
    try {
      String? deviceId = UserPreference.getString(PrefKeys.deviceId);
      log("deviceId =====> $deviceId");

      await device.disconnect();
    } catch (e) {
      log("Connection error: $e");
    }
  }
}
