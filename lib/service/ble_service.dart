import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:infinity_circuit/extentions/ble_characteristics_ext.dart';
import 'package:infinity_circuit/extentions/list_int_ext.dart';
import 'package:infinity_circuit/models/network/request_models/ble_request_model/ble_read_settings_request_model.dart';

import '../constants/enums/ble_enum.dart';
import '../exports.dart';
import '../extentions/ble_device_ext.dart';
import '../models/network/request_models/ble_request_model/ble_read_settings_response_model.dart';
import '../utils/common_utils.dart';

export 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEService {
  static final BLEService _instance = BLEService._internal();

  BLEService._internal();

  static BLEService get instance => _instance;

  /// *********************************** Battery Stream ***********************************
  StreamController<int> batteryStreamController =
      StreamController<int>.broadcast();

  Stream<int> get batteryStream => batteryStreamController.stream;

  /// *********************************** Battery Stream ***********************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// ******************** Scan Result And Device Variable Declarations ********************
  ScanResult? _scanResult;

  ScanResult? get scanResult => _scanResult;

  BluetoothDevice? get device => _scanResult?.device;

  int? get mtu => device?.mtuNow;

  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  BluetoothConnectionState get connectionState => _connectionState;

  ValueNotifier<bool> isConnected = ValueNotifier<bool>(false);
  // bool get isConnected =>
  //     _connectionState == BluetoothConnectionState.connected;

  /// ************************ Scan Result And Device Variable Declarations *************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Initialise BLE Service *************************************
  Future<void> init(ScanResult? result) async {
    /// Set Device Result
    _scanResult = result;
    if (batteryStreamController.isClosed) {
      batteryStreamController = StreamController<int>.broadcast();
    }
  }

  /// *********************************** End Initialise BLE Service *********************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Query Battery Percentage ***********************************
  void getBatteryPercentage() async {
    /// Checks Scan Result
    if (_scanResult != null) {
      /// Check Device Connection Status
      if (_scanResult!.device.isConnected) {
        BluetoothService? service =
            getService(Guid(AppConstants.batteryServiceUUID));
        if (service != null) {
          log("Battery Service Found",
              name: "BLEService.instance.getBatteryPercentage");

          /// Find Device Battery Level Characteristics Filtered by UUID
          int? batteryCharacteristicsIndex = service.characteristics.indexWhere(
              (element) => element.uuid == Guid(AppConstants.batteryLevelUUID));
          if (batteryCharacteristicsIndex != -1) {
            log("Battery Characteristic Found",
                name: "BLEService.instance.getBatteryPercentage");

            /// Found Device Battery Level Characteristic

            BluetoothCharacteristic characteristic =
                service.characteristics[batteryCharacteristicsIndex];
            List<int> batteryData = await characteristic.read();
            int battery = 0;

            /// Check Read Operation Enabled
            if (characteristic.properties.read) {
              log("Battery Value $batteryData",
                  name: "BLEService.instance.getBatteryPercentage");

              if (batteryData.isNotEmpty) {
                scheduleMicrotask(() {
                  battery = batteryData.listToDecimal();
                  // battery = listToDecimal(batteryData);
                  batteryStreamController.add(battery);
                });
              }
            }
            log("Battery Value ${characteristic.isNotifying}",
                name: "BLEService.instance.getBatteryPercentage");

            /// Check Notify Operation Supported
            if (characteristic.isNotifying == false) {
              /// Enable Notify Operation
              await characteristic
                  .setNotifyValue(characteristic.isNotifying == false);
            }

            /// Listen Updated Value Stream

            characteristic.lastValueStream.listen((event) {
              // log("Battery Updated Value $event",
              //     name: "BLEService.instance.getBatteryPercentage");
              scheduleMicrotask(() {
                battery = event.listToDecimal();

                // battery = listToDecimal(event);
                batteryStreamController.add(battery);
              });
            });
          } else {
            log("Device Battery Characteristics Not Found",
                name: "[BLEService.instance.getBatteryPercentage]");
          }
        } else {
          log("Device Battery Service Not Found",
              name: "[BLEService.instance.getBatteryPercentage]");
        }
      } else {
        log("No Device Connected",
            name: "[BLEService.instance.getBatteryPercentage]");
      }
    }
  }

  void resetBatteryStream() {
    if (batteryStreamController.isClosed) {
      batteryStreamController = StreamController<int>.broadcast();
    }

    /// Set Initial Values
    if (!batteryStreamController.isClosed) {
      batteryStreamController.add(0);
    }
  }

  /// *********************************** Query Battery Percentage ***********************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Manage Connection State ************************************
  void updateConnectionState(BluetoothConnectionState state) {
    _connectionState = state;
    switch (state) {
      case BluetoothConnectionState.disconnected:
        resetBatteryStream();
        isConnected.value = false;
      case BluetoothConnectionState.connected:
        isConnected.value = true;

      default:
        break;
    }
  }

  /// *********************************** End Manage Connection State ***********************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// ****************************************** Write Command ******************************************
  Future<void> communicate({
    List<int> data = const [],
    required BLEType type,
    BLECommandType? command,
    required Function(BLECommandType commandType, List<int> data) onSuccess,
    required OnError onError,
  }) async {
    if (_scanResult == null || _scanResult?.device.isDisconnected == true) {
      // CommonUtils.displayToast("Unable to write, Device is not connected",
      //     state: ToastStats.error);
      onError(BLECommandStatus.internalError);

      /// check device connection state and, display toast with return method.
      return;
    }
    BluetoothService? service = getService(Guid(AppConstants.bleServiceUUID));

    /// Read
    BluetoothCharacteristic? rxCharacteristics;

    /// Write
    BluetoothCharacteristic? txCharacteristics;
    if (service == null) {
      return;
    } else {
      rxCharacteristics = getRxCharacteristic();
      txCharacteristics = getTxCharacteristic();
    }
    switch (type) {
      case BLEType.write:
        try {
          if (txCharacteristics == null || !txCharacteristics.isWritable) {
            return;
          }
          await txCharacteristics.writeCharacteristic(
            data,
            onSuccess: (command) {
              onSuccess(command, []);
            },
            onError: (p0) {
              onError(p0);
            },
          );
        } catch (e) {
          onError(e);
        }
      case BLEType.read:
        try {
          if (rxCharacteristics == null || !rxCharacteristics.isReadable) {
            return;
          }
          await rxCharacteristics.readCharacteristic(
            command: command!,
            onSuccess: (commandType, result) {
              onSuccess(commandType, result);
            },
            onError: (p0) {
              onError(p0);
            },
          );
        } catch (e) {
          onError(e);
        }
      default:
        log("Error While Writing Data: $data , type : ${type.value}",
            name: "[BLEService.instance.writeCommand]");
    }
  }

  /// *************************************** End Write Command ***************************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Service Finder ***************************************
  BluetoothService? getService(Guid guid) {
    int? serviceIndex = _scanResult!.device.servicesList
        .indexWhere((element) => element.serviceUuid == guid);
    if (serviceIndex != -1) {
      return _scanResult!.device.servicesList[serviceIndex];
    } else {
      return null;
    }
  }

  /// *********************************** End Service Finder ***************************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Characteristic Finder ***************************************
  BluetoothCharacteristic? getCharacteristic(Guid serviceGuid, Guid charGuid) {
    BluetoothService? service = getService(serviceGuid);
    if (service != null) {
      int? charIndex = service.characteristics
          .indexWhere((element) => element.uuid == charGuid);
      if (charIndex != -1) {
        return service.characteristics[charIndex];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// *********************************** End Characteristic Finder ***************************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Get RX Characteristics ***************************************
  /// Read Command
  BluetoothCharacteristic? getRxCharacteristic() {
    return getCharacteristic(
        Guid(AppConstants.bleServiceUUID), AppConstants.rxServiceUUID);
  }

  /// *********************************** End RX Characteristics ***********************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Get TX Characteristics ***********************************
  /// Write Command
  BluetoothCharacteristic? getTxCharacteristic() {
    return getCharacteristic(
        Guid(AppConstants.bleServiceUUID), AppConstants.txServiceUUID);
  }

  /// *********************************** End TX Characteristics ***********************************
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// *********************************** Read Settings Data ***********************************
  Future<BLEReadSettingsResponseModel?> readSettingsData() async {
    BLEReadSettingsResponseModel? responseData;
    BLEEventRequestModel requestData = BLEEventRequestModel(
        orderId: BLEType.read.value,
        commandId: "0${BLECommandType.settings.value}",
        totalPackets: "01",
        currentPacket: "01",
        payloadLength: "00");
    await communicate(
      type: BLEType.read,
      command: BLECommandType.settings,
      data: requestData.buildValue,
      onSuccess: (commandType, data) {
        responseData = BLEReadSettingsResponseModel.fromData(data);
      },
      onError: (p0) {
        CommonUtils.displayToast(
          "Unable to fetch device settings",
          state: ToastStats.error,
        );
      },
    );
    return responseData;
  }

  /// *********************************** End TX Characteristics ***********************************

  void getDeviceInfo() async {
    BluetoothCharacteristic? manufactureNameCharacteristic = getCharacteristic(
        AppConstants.deviceInfoServiceUUID, AppConstants.manufactureNameUUID);
    String? manufactureName;

    if (manufactureNameCharacteristic != null) {
      List<int> data = await manufactureNameCharacteristic.read();
      manufactureName = data.readValue();
    }
  }

  /// Dispose For All Streams
  void dispose() {
    batteryStreamController.close();
  }
}
