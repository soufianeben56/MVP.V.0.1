
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

class BLEMediaRequestModel {
  final List<Uint8List> requestData;
  final List<int>  imageData;

  BLEMediaRequestModel({
    required this.requestData,
    required this.imageData,
  });

}
