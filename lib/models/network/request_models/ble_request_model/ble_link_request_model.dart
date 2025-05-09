import 'dart:developer';

class BLELinkRequestModel {
  final String orderId;
  final String commandId;
  final String totalPackets;
  final String currentPacket;
  final String payloadLength;
  final String payload;

  BLELinkRequestModel({
    required this.orderId,
    required this.commandId,
    required this.totalPackets,
    required this.currentPacket,
    required this.payloadLength,
    required this.payload,
  });

  @override
  String toString() {
    log("OrderId : $orderId CommandId : $commandId Total Packets : $totalPackets Current Packet : $currentPacket Payload Length : $payloadLength Payload : $payload");
    return "$orderId$commandId$totalPackets$currentPacket$payloadLength$payload";
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
