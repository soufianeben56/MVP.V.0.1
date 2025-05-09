import '../constants/enums/ble_enum.dart';

extension IntX on int {
  bool isUnAuthenticated() => this == 401;
  bool isBadResponse() => this == 400;
  bool isInternalError() => this == 500;

  BLEType getOperationId() {
    switch (this) {
      case 1:
        return BLEType.write;
      case 2:
        return BLEType.read;
      case 3:
        return BLEType.notify;
      default:
        return BLEType.write;
    }
  }

  BLECommandType getCommandType() {
    switch (this) {
      case 1:
        return BLECommandType.notes;
      case 2:
        return BLECommandType.event;
      case 3:
        return BLECommandType.link;
      case 4:
        return BLECommandType.image;
      case 5:
        return BLECommandType.weather;
      case 6:
        return BLECommandType.syncTime;
      case 7:
        return BLECommandType.syncLocation;
      case 8:
        return BLECommandType.settings;
      default:
        return BLECommandType.notes;
    }
  }

  BLECommandStatus getCommandStatus() {
    switch (this) {
      case 0:
        return BLECommandStatus.success;
      case 1:
        return BLECommandStatus.commandNotSupported;

      case 2:
        return BLECommandStatus.busy;

      case 3:
        return BLECommandStatus.iDNotSupported;

      case 4:
        return BLECommandStatus.wrongIDValue;

      case 5:
        return BLECommandStatus.iDValueOutRange;

      case 6:
        return BLECommandStatus.iDValueNotSupported;

      case 7:
        return BLECommandStatus.iDNotWritable;

      case 8:
        return BLECommandStatus.iDNotReadable;

      case 9:
        return BLECommandStatus.iDNotApplicable;

      case 10:
        return BLECommandStatus.internalError;

      default:
        return BLECommandStatus.internalError;
    }
  }

  int hexToDecimal() {
    return int.parse(toString(), radix: 16);
  }
}
