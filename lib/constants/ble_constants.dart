import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:infinity_circuit/exports.dart';

// Define BleConstants with UUIDs
class BleConstants {
  static const String SERVICEUUID = '7ea355bd-feb2-426e-83e4-7a90f3ad32a4';
  static const String READCHARACTERISTICUUID =
      '7ea355bd-feb4-426e-83e4-7a90f3ad32a4';
  static const String WRITECHARACTERISTICUUID =
      '7ea355bd-feb3-426e-83e4-7a90f3ad32a4';
}

bool isDeviceConnected = false;

// Function to read predefined characteristic using deviceId
Future<List<int>> readCharacteristicFromDeviceId(String deviceId) async {
  try {
    // Retrieve the device from the deviceId
    BluetoothDevice device = BluetoothDevice.fromId(deviceId);

    // Get the service by predefined serviceId
    BluetoothService service = (await device.discoverServices())
        .firstWhere((s) => s.uuid == Guid(BleConstants.SERVICEUUID));

    // Get the characteristic by predefined readCharacteristicId
    BluetoothCharacteristic characteristic = service.characteristics
        .firstWhere((c) => c.uuid == Guid(BleConstants.READCHARACTERISTICUUID));
    log("characteristic.properties.read   ${characteristic.properties}");

    // Check if the characteristic is readable
    if (characteristic.properties.read) {
      // Read the characteristic value
      List<int> value = await characteristic.read();
      log("value ==> $value");

      // Convert to ASCII string and return
      // String stringValue = utf8.decode(value);
      // log("stringValue ==> $stringValue");
      return value;
    } else {
      print('Characteristic is not readable');
      return [];
    }
  } catch (e, s) {
    print('Error reading characteristic: $e');
    print('Error reading characteristic: $s');
    isDeviceConnected = false;
    /*if (e.toString().contains("device is not connected")) {

    }*/
    return [];
  }
}

// Function to connect to the device
Future<BluetoothDevice?> connectToDevice(String deviceId) async {
  try {
    BluetoothDevice device = BluetoothDevice.fromId(deviceId);

    // Connect to the device
    await device.connect();

    // Wait until the device is connected
    await device.state
        .firstWhere((state) => state == BluetoothDeviceState.connected);

    return device;
  } catch (e) {
    print('Error connecting to device: $e');
    return null;
  }
}

Future<bool> writeCharacteristicToDeviceId(String deviceId, String data) async {
  try {
    // Retrieve the device from the deviceId
    BluetoothDevice device = BluetoothDevice.fromId(deviceId);

    // Get the service by predefined serviceId
    BluetoothService service = (await device.discoverServices())
        .firstWhere((s) => s.uuid == Guid(BleConstants.SERVICEUUID));

    // Get the characteristic by predefined writeCharacteristicId
    BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
        (c) => c.uuid == Guid(BleConstants.WRITECHARACTERISTICUUID));
    log("characteristic.properties.write   ${characteristic.properties}");

    // Check if the characteristic is writable
    if (characteristic.properties.write) {
      // Convert the string data to a List<int> (UTF-8 encoding)
      List<int> value = utf8.encode(data);

      // Write the characteristic value
      await characteristic.write(value);
      log("Data written successfully");

      return true;
    } else {
      print('Characteristic is not writable');
      return false;
    }
  } catch (e) {
    print('Error writing characteristic: $e');
    return false;
  }
}

Map<String, double> processBleData(List<int> data) {
  log("processBleData ::$data");
  double? voltage, current, sinewave, diode;

  // Check and extract the voltage (Bytes 1 to 4)
  if (data.length >= 4) {
    voltage = _bytesToDouble(data.sublist(0, 4));
  } else {
    log("Insufficient data for Voltage");
    return {};
  }

  // Check and extract the current (Bytes 5 to 8)
  if (data.length >= 8) {
    current = _bytesToDouble(data.sublist(4, 8));
  } else {
    log("Insufficient data for Current");
  }

  // Check and extract the sinewave (Bytes 9 to 12)
  if (data.length >= 12) {
    sinewave = _bytesToDouble(data.sublist(8, 12));
  } else {
    log("Insufficient data for Sinewave");
  }

  // Check and extract the diode (Bytes 13 to 16)
  if (data.length >= 16) {
    diode = _bytesToDouble(data.sublist(12, 16));
  } else {
    log("Insufficient data for Diode");
  }

  // Return available values
  return {
    if (voltage != null) 'voltage': voltage,
    if (current != null) 'current': current,
    if (sinewave != null) 'sinewave': sinewave,
    if (diode != null) 'diode': diode
  };
}

double _bytesToDouble(List<int> bytes) {
  ByteData byteData = ByteData.sublistView(Uint8List.fromList(bytes));
  return byteData.getFloat32(
      0, Endian.little); // Assuming little-endian byte order
}
