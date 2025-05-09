class BLEWriteSettingsRequestModel {
  final String orderId,
      commandId,
      totalPackets,
      currentPacket,
      payloadLength,
      timeZone,
      timeFormat,
      clockFormat,
      dateFormat,
      color;

  BLEWriteSettingsRequestModel({
    required this.orderId,
    required this.commandId,
    required this.totalPackets,
    required this.currentPacket,
    required this.payloadLength,
    required this.timeZone,
    required this.timeFormat,
    required this.clockFormat,
    required this.dateFormat,
    required this.color,
  });

  @override
  String toString() {
    return orderId +
        commandId +
        totalPackets +
        currentPacket +
        payloadLength +
        timeZone +
        timeFormat +
        clockFormat +
        dateFormat +
        color;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["orderId"] = orderId;
    data["commandId"] = commandId;
    data["totalPackets"] = totalPackets;
    data["currentPacket"] = currentPacket;
    data["payloadLength"] = payloadLength;
    data["timeZone"] = timeZone;
    data["timeFormat"] = timeFormat;
    data["clockFormat"] = clockFormat;
    data["dateFormat"] = dateFormat;
    data["fontColor"] = color;
    return data;
  }

  // List<int> get buildValue => toString().buildWriteValue();
  List<int> get buildValue {
    // Ensure the hex string has an even length
    if (toString().length % 2 != 0) {
      throw const FormatException("Hex string must have an even length");
    }

    List<int> hexValues = [];

    for (int i = 0; i < toString().length; i += 2) {
      String hexPair = toString().substring(i, i + 2);
      int value = int.parse(hexPair, radix: 16);
      hexValues.add(value);
    }

    return hexValues;
  }
}
