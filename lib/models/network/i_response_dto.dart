import 'dart:convert';

class IResponseDTO {
  Map<String, dynamic>? data;
  int? statusCode;
  String? message;
  bool? status;
  String? url;

  IResponseDTO(
      {this.data, this.statusCode, this.message, this.status, this.url});

  IResponseDTO.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['status_code'];
    message = json['message'];
    status = json['status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['status_code'] = statusCode;
    data['message'] = message;
    data['status'] = status;
    data['url'] = url;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}
