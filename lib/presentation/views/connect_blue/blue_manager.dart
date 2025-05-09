import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEManager {
  static final BLEManager _instance = BLEManager._internal();
  BluetoothDevice? connectedDevice;
  Function(Uint8List)? dataCallback;
  bool dataTransmissionEnabled = false;
  final ValueNotifier<bool> connectionStatus = ValueNotifier(false);

  BluetoothCharacteristic? _dataCharacteristic;
  BluetoothCharacteristic? _commandCharacteristic;
  StreamSubscription<BluetoothConnectionState>? _deviceStateSubscription;

  factory BLEManager() => _instance;

  BLEManager._internal();

  bool isDeviceConnected() {
    if (kDebugMode) print("Device connected status: ${connectedDevice != null && connectionStatus.value}");
    return connectedDevice != null && connectionStatus.value;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await disconnectFromDevice();
    try {
      await device.connect();
      connectedDevice = device;
      connectionStatus.value = true;
      if (kDebugMode) print("Connected to device: ${device.platformName}");
      await _discoverServicesAndCharacteristics();

      _deviceStateSubscription = device.state.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          if (kDebugMode) print("Device disconnected unexpectedly.");
          _handleDisconnection();
        }
      }) as StreamSubscription<BluetoothConnectionState>?;
    } catch (e) {
      if (kDebugMode) print("Error connecting to device: $e");
    }
  }

  Future<void> _discoverServicesAndCharacteristics() async {
    if (connectedDevice == null) return;

    try {
      List<BluetoothService> services = await connectedDevice!.discoverServices();
      if (kDebugMode) print("Discovered services: ${services.length}");

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic char in service.characteristics) {
          if (char.uuid.toString() == "dcba4321-ba21-dc43-fe65-0987654321ba") {
            _dataCharacteristic = char;
            if (kDebugMode) print("Data characteristic found.");
          } else if (char.uuid.toString() == "abcd1234-ab12-cd34-ef56-1234567890ab") {
            _commandCharacteristic = char;
            if (kDebugMode) print("Command characteristic found.");
          }
        }
      }

      if (_dataCharacteristic != null) {
        await _dataCharacteristic!.setNotifyValue(true);
        _dataCharacteristic!.lastValueStream.listen((value) {
          if (dataCallback != null && dataTransmissionEnabled) {
            dataCallback!(Uint8List.fromList(value));
            if (kDebugMode) print("Data received: $value");
          }
        });
        if (kDebugMode) print("Subscribed to data notifications.");
      }
    } catch (e) {
      if (kDebugMode) print("Error discovering services: $e");
    }
  }

  Future<void> sendCommand(String command) async {
    if (_commandCharacteristic != null) {
      try {
        await _commandCharacteristic!.write(command.codeUnits, withoutResponse: false);
        if (kDebugMode) print("Command sent: $command");
        
        // Aktiviere die Datenübertragung für alle START-Befehle
        if (command.startsWith("START")) {
          dataTransmissionEnabled = true;
          if (kDebugMode) print("Data transmission enabled for command: $command");
        } else if (command.startsWith("STOP") || command == "RESET_DIODE") {
          dataTransmissionEnabled = false;
          if (kDebugMode) print("Data transmission disabled for command: $command");
        }
      } catch (e) {
        if (e.toString().contains("device is not connected")) {
          _handleDisconnection();
        }
        if (kDebugMode) print("Error sending command: $e");
      }
    } else {
      if (kDebugMode) print("Command characteristic not available.");
    }
  }

  Future<void> sendFrequency(double frequency) async {
    if (_commandCharacteristic != null) {
      try {
        if (frequency > 0) {
          String frequencyString = frequency.toString();
          await _commandCharacteristic!.write(frequencyString.codeUnits, withoutResponse: false);
          if (kDebugMode) print("Frequency sent: $frequencyString");
        } else {
          if (kDebugMode) print("Frequency set to zero. Stopping frequency updates.");
        }
      } catch (e) {
        if (kDebugMode) print("Error sending frequency: $e");
      }
    } else {
      if (kDebugMode) print("Command characteristic not available.");
    }
  }

  Future<void> disconnectFromDevice() async {
    if (connectedDevice != null) {
      try {
        await connectedDevice!.disconnect();
        if (kDebugMode) print("Device disconnected manually.");
      } catch (e) {
        if (kDebugMode) print("Error disconnecting from device: $e");
      } finally {
        _handleDisconnection();
      }
    }
  }

  void _handleDisconnection() {
    if (connectedDevice != null) {
      connectedDevice = null;
      dataTransmissionEnabled = false;
      connectionStatus.value = false;
      _deviceStateSubscription?.cancel();
      _deviceStateSubscription = null;
      if (kDebugMode) print("Device disconnected and resources cleaned up.");
    }
  }
}
