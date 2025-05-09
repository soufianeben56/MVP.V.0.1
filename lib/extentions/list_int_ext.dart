

import 'dart:typed_data';

import 'package:flutter/material.dart';

extension ListIntegerExt on List<int>{

  int listToDecimal(){
    num decimalValue = 0;
    for (int i = 0; i < length; i++) {
      decimalValue = decimalValue * 256 + this[i];
    }
    return decimalValue.toInt();
  }

  String readValue() {
    final buffer = StringBuffer();
    for (int value in this) {
      buffer.writeCharCode(value);
    }
    return buffer.toString();
  }

  Image imageFromIntList() {
    // Convert List<int> to Uint8List
    Uint8List uint8List = Uint8List.fromList(this);
    // Return Image widget
    return Image.memory(uint8List);
  }

  Color toColor() {
    if (length != 3) {
      throw ArgumentError('List must have exactly 3 elements.');
    }
    return Color.fromARGB(255, this[0], this[1], this[2]);
  }
}