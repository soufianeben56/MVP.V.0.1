import 'dart:math';
import 'dart:developer' as d;
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:infinity_circuit/exports.dart';

import '../constants/enums/ble_enum.dart';
import '../utils/common_utils.dart';
import 'ble_device_ext.dart';

// split write should be used with caution.
//    1. due to splitting, `characteristic.read()` will return partial data.
//    2. it can only be used *with* response to avoid data loss
//    3. The characteristic must be designed to support split data
extension BluetoothCharacteristicX on BluetoothCharacteristic {
  Future<void> splitWrite(List<int> value, {int timeout = 15}) async {
    int chunk = device.mtuNow - 3; // 3 bytes ble overhead
    for (int i = 0; i < value.length; i += chunk) {
      List<int> subValue = value.sublist(i, min(i + chunk, value.length));
      d.log("writing value$subValue", name: "splitWrite");
      await write(subValue, withoutResponse: false, timeout: timeout)
          .then((value) {
        _packetsSent++;
      });
    }
  }

  Future<void> writeCharacteristic(
    List<int> value, {
    int timeout = 15,
    required Function(BLECommandType commandType) onSuccess,
    required OnError onError,
  }) async {
    int commandId = value[1];
    await write(value, timeout: timeout).then((value) async {
      await Future.delayed(const Duration(milliseconds: 100));

      onSuccess(commandId.getCommandType());
    }).catchError((e) {
      onError(e);
    }).onError((error, stackTrace) {
      onError(error);
    });
  }

  Future<void> readCharacteristic({
    required BLECommandType command,
    required Function(BLECommandType commandType, List<int> data) onSuccess,
    required OnError onError,
  }) async {
    List<int> data = await read().whenComplete(() {});
    CommonUtils.logX(
      "Data :: $data",
      "readCharacteristic",
    );
    if (data.isNotEmpty) {
      int commandId = data[1];
      int status = data[2];
      // if (operationId != 2) {
      //   CommonUtils.logX("operationId :: $operationId", "readCharacteristic");
      //   onError(BLECommandStatus.internalError);
      //   return;
      // }
      if (commandId != command.value) {
        CommonUtils.logX("commandId :: $commandId", "readCharacteristic");
        CommonUtils.logX(
            "Command Value :: ${command.value}", "readCharacteristic");

        onError(BLECommandStatus.internalError);

        return;
      }
      switch (status) {
        case 0:
          {
            BLECommandType type = commandId.getCommandType();
            onSuccess(type, data);
          }
          break;
        case 1:
          onError(BLECommandStatus.commandNotSupported);
          break;

        case 2:
          onError(BLECommandStatus.busy);
          break;

        case 3:
          onError(BLECommandStatus.iDNotSupported);
          break;

        case 4:
          onError(BLECommandStatus.wrongIDValue);
          break;

        case 5:
          onError(BLECommandStatus.iDValueOutRange);
          break;

        case 6:
          onError(BLECommandStatus.iDValueNotSupported);
          break;

        case 7:
          onError(BLECommandStatus.iDNotWritable);
          break;

        case 8:
          onError(BLECommandStatus.iDNotReadable);
          break;

        case 9:
          onError(BLECommandStatus.iDNotApplicable);
          break;

        case 10:
          onError(BLECommandStatus.internalError);
          break;
        default:
          onError(BLECommandStatus.internalError);

          break;
      }
    } else {
      onError("Transaction UnSuccessful");
    }
  }

  int totalPackets(List<int> data) {
    int chunk = device.mtuNow - 9; // 3 bytes ble overhead
    return (data.length / chunk).ceil();
  }

  static int _packetsSent = 1;

  int get packetsSent => _packetsSent;

  void resetPacketValue() {
    _packetsSent = 1;
  }

  bool get isReadable => properties.read;

  bool get isWritable => properties.write;

  bool get isNotify => properties.notify;

  bool get isWriteWithoutResponse => properties.writeWithoutResponse;

  Future<void> setNotify() async {
    await setNotifyValue(isNotifying == false);
  }
}
