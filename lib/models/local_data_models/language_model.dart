import 'package:infinity_circuit/exports.dart';

class LanguageModel {
  String? label;
  String? code;
  Widget? flag;
  LanguageModel({this.label, this.code, this.flag});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['code'] = code;
    return data;
  }
}
