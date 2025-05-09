import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/extentions/list_int_ext.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import '../../../../constants/enums/ble_enum.dart';
import '../../../../utils/common_utils.dart';

class BLEReadSettingsResponseModel {
  BLEType? orderId;
  BLECommandType? commandId;
  BLECommandStatus? statusCode;
  String? totalPackets;
  String? currentPacket;
  String? payloadLength;
  String? timeZone;
  String? timeFormat;
  String? clockFormat;
  String? dateFormat;
  Color? fontColor;

  List<int> _data = [];

  BLEReadSettingsResponseModel({
    this.orderId,
    this.commandId,
    this.statusCode,
    this.totalPackets,
    this.currentPacket,
    this.payloadLength,
    this.timeZone,
    this.timeFormat,
    this.clockFormat,
    this.dateFormat,
    this.fontColor,
  });

  BLEReadSettingsResponseModel.fromData(List<int> result) {
    _data = result;
    if (_data.isNotEmpty) {
      /// Order Id
      try {
        orderId = _data[0].getOperationId();
      } catch (e) {
        Exception("order id Error$e");
      }

      /// Command Id
      try {
        commandId = _data[1].getCommandType();
      } catch (e) {
        Exception("commandId Error$e");
      }

      /// Status Code
      try {
        statusCode = _data[2].getCommandStatus();
      } catch (e) {
        Exception("statusCode Error$e");
      }

      /// No. Of Packets
      try {
        totalPackets = _data[3].hexToDecimal().toString();
      } catch (e) {
        Exception("totalPackets Error$e");
      }

      /// Current Packet
      try {
        currentPacket = _data[4].hexToDecimal().toString();
      } catch (e) {
        Exception("currentPacket Error$e");
      }

      /// Payload Length
      try {
        payloadLength = _data[5].toString();
      } catch (e) {
        Exception("payloadLength Error$e");
      }

      /// Timezone Data
      try {
        List<int> timeZoneData = _data.sublist(6, 15);
        timeZone = timeZoneData.readValue();
      } catch (e) {
        Exception("timeZone Error$e");
      }

      /// Time Format
      try {
        timeFormat = _data[15].toString();
      } catch (e) {
        Exception("timeFormat Error$e");
      }

      /// Clock Format
      try {
        clockFormat = _data[16].toString();
      } catch (e) {
        Exception("clockFormat Error$e");
      }

      /// Date Format
      try {
        List<int> dateFormatData = _data.sublist(17, 27);
        dateFormat = dateFormatData.readValue();
      } catch (e) {
        Exception("dateFormat Error$e");
      }

      /// Font Color
      try {
        List<int> fontColorData = _data.sublist(27, 30);

        fontColor = fontColorData.toColor();
      } catch (e) {
        Exception("fontColor Error$e");
      }
    } else {
      CommonUtils.displayToast(
        "Unable to retrieve settings",
        state: ToastStats.error,
      );
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["orderId"] = orderId;
    data["commandId"] = commandId;
    data["statusCode"] = statusCode;
    data["totalPackets"] = totalPackets;
    data["currentPacket"] = currentPacket;
    data["payloadLength"] = payloadLength;
    data["timeZone"] = timeZone;
    data["timeFormat"] = timeFormat;
    data["clockFormat"] = clockFormat;
    data["dateFormat"] = dateFormat;
    data["fontColor"] = fontColor?.hex;
    return data;
  }
}
