// class BluetoothServiceResponse {
//   final String remoteId;
//   final String serviceUuid;
//   final bool isPrimary;
//   final List<BluetoothCharacteristicResponse> characteristics;
//   final List<BluetoothServiceResponse> includedServices;
//
//   BluetoothServiceResponse({
//     required this.remoteId,
//     required this.serviceUuid,
//     required this.isPrimary,
//     required this.characteristics,
//     required this.includedServices,
//   });
// }

class BluetoothServiceResponse {
  final String remoteId;
  final String serviceUuid;
  final bool isPrimary;
  final List<BluetoothCharacteristicResponse> characteristics;
  final List<BluetoothServiceResponse> includedServices;

  BluetoothServiceResponse({
    required this.remoteId,
    required this.serviceUuid,
    required this.isPrimary,
    required this.characteristics,
    required this.includedServices,
  });

  // Convert a BluetoothServiceResponse instance to JSON
  Map<dynamic, dynamic> toJson() {
    return {
      'remoteId': remoteId,
      'serviceUuid': serviceUuid,
      'isPrimary': isPrimary,
      'characteristics': characteristics.map((char) => char.toJson()).toList(),
      'includedServices': includedServices.map((svc) => svc.toJson()).toList(),
    };
  }

  // Create a BluetoothServiceResponse instance from JSON
  factory BluetoothServiceResponse.fromJson(Map<dynamic, dynamic> json) {
    return BluetoothServiceResponse(
      remoteId: json['remoteId'] as String,
      serviceUuid: json['serviceUuid'] as String,
      isPrimary: json['isPrimary'] as bool,
      characteristics: (json['characteristics'] as List<dynamic>)
          .map((charJson) => BluetoothCharacteristicResponse.fromJson(
              charJson as Map<String, dynamic>))
          .toList(),
      includedServices: (json['includedServices'] as List<dynamic>)
          .map((svcJson) => BluetoothServiceResponse.fromJson(
              svcJson as Map<dynamic, dynamic>))
          .toList(),
    );
  }
}

// class BluetoothCharacteristicResponse {
//   final String remoteId;
//   final String serviceUuid;
//   final String characteristicUuid;
//   final List<BluetoothDescriptorResponse> descriptors;
//   final CharacteristicPropertiesResponse properties;
//
//   BluetoothCharacteristicResponse({
//     required this.remoteId,
//     required this.serviceUuid,
//     required this.characteristicUuid,
//     required this.descriptors,
//     required this.properties,
//   });
// }
class BluetoothCharacteristicResponse {
  final String remoteId;
  final String serviceUuid;
  final String characteristicUuid;
  final List<BluetoothDescriptorResponse> descriptors;
  final CharacteristicPropertiesResponse properties;

  BluetoothCharacteristicResponse({
    required this.remoteId,
    required this.serviceUuid,
    required this.characteristicUuid,
    required this.descriptors,
    required this.properties,
  });

  // Convert a BluetoothCharacteristicResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'remoteId': remoteId,
      'serviceUuid': serviceUuid,
      'characteristicUuid': characteristicUuid,
      'descriptors': descriptors.map((d) => d.toJson()).toList(),
      'properties': properties.toJson(),
    };
  }

  // Create a BluetoothCharacteristicResponse instance from JSON
  factory BluetoothCharacteristicResponse.fromJson(Map<String, dynamic> json) {
    return BluetoothCharacteristicResponse(
      remoteId: json['remoteId'],
      serviceUuid: json['serviceUuid'],
      characteristicUuid: json['characteristicUuid'],
      descriptors: (json['descriptors'] as List)
          .map((d) => BluetoothDescriptorResponse.fromJson(d))
          .toList(),
      properties: CharacteristicPropertiesResponse.fromJson(json['properties']),
    );
  }
}

class BluetoothDescriptorResponse {
  final String descriptorUuid;
  final String lastValue; // Change to String

  BluetoothDescriptorResponse({
    required this.descriptorUuid,
    required this.lastValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'descriptorUuid': descriptorUuid,
      'lastValue': lastValue,
    };
  }

  factory BluetoothDescriptorResponse.fromJson(Map<String, dynamic> json) {
    return BluetoothDescriptorResponse(
      descriptorUuid: json['descriptorUuid'],
      lastValue: json['lastValue'],
    );
  }
}

class CharacteristicPropertiesResponse {
  final bool read;
  final bool write;
  final bool notify;
  final bool indicate;

  CharacteristicPropertiesResponse({
    required this.read,
    required this.write,
    required this.notify,
    required this.indicate,
  });

  // Convert a CharacteristicPropertiesResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'read': read,
      'write': write,
      'notify': notify,
      'indicate': indicate,
    };
  }

  // Create a CharacteristicPropertiesResponse instance from JSON
  factory CharacteristicPropertiesResponse.fromJson(Map<String, dynamic> json) {
    return CharacteristicPropertiesResponse(
      read: json['read'],
      write: json['write'],
      notify: json['notify'],
      indicate: json['indicate'],
    );
  }
}
