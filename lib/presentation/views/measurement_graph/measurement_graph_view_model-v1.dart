import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../service/routing/route_paths.dart';
import '../../../ui/app_colors.dart';
import '../connect_blue/blue_manager.dart';
import 'CustomGraphViewModel.dart';


class MeasurementGraphViewModel extends ChangeNotifier {
  final List<FlSpot> _voltageData = [];
  final List<FlSpot> _currentData = [];
  double _sliderValue = 10;
  double _freqSliderValue = 0;
  double time = 0;
  bool isRunning = false;
  final int maxDisplayPoints = 100;
  double rxValue = 0;
  double? rMax;

  Function()? onDisconnected;

  List<FlSpot> get voltageData => _voltageData;
  List<FlSpot> get currentData => _currentData;
  double get sliderValue => _sliderValue;
  double get freqSliderValue => _freqSliderValue;

  MeasurementGraphViewModel() {
    BLEManager().dataCallback = onDataReceived;
    BLEManager().connectionStatus.addListener(_onConnectionStatusChanged);
    if (kDebugMode) print("FROM MODEL: MeasurementGraphViewModel initialized.");
  }

  void _onConnectionStatusChanged() {
    if (!BLEManager().connectionStatus.value) {
      if (kDebugMode) print("FROM MODEL: Device disconnected.");
      stopDataReception();
      onDisconnected?.call();
      notifyListeners();
    }
  }

  void onDataReceived(Uint8List data) {
    if (kDebugMode) print("FROM MODEL: Data received: $data");
    ByteData byteData = ByteData.sublistView(data);

    // Unterscheidung zwischen DC- und AC-Modus anhand der Datenlänge
    if (data.length == 4) {
      // DC-Modus: Ein einzelner SensorData-Wert (4 Byte)
      int voltageRaw = byteData.getInt16(0, Endian.little);
      int currentRaw = byteData.getInt16(2, Endian.little);
      double voltage = voltageRaw / 100.0;
      double current = currentRaw / 10000.0;  // Im DC-Modus andere Skalierung


      if (kDebugMode) {
        print("FROM MODEL: DC mode data point (time: $time, voltage: $voltage, current: $current)");
      }
      addDataPoint(time, voltage, current);
      time += 0.1;
      // rxValue-Berechnung beibehalten
      if (rMax != null) {
        rxValue = (voltage / 3.3) * rMax!;
        if (kDebugMode) print("FROM MODEL: Updated rxValue to $rxValue");
      }
    } else if (data.length == 164) {
      // AC-Modus: Die ersten 4 Byte enthalten die sequenceNumber, danach 40 SensorData-Werte
      int sequenceNumber = byteData.getUint32(0, Endian.little);
      if (kDebugMode) print("FROM MODEL: Sequence Number: $sequenceNumber");
      
      int numSamples = (data.length - 4) ~/ 4;
      for (int i = 0; i < numSamples; i++) {
        int offset = 4 + i * 4;
        int voltageRaw = byteData.getInt16(offset, Endian.little);
        int currentRaw = byteData.getInt16(offset + 2, Endian.little);
        double voltage = voltageRaw / 100.0;
        double current = currentRaw / 1000.0;  // Im AC-Modus Standardskalierung
        
        if (kDebugMode) {
          print("FROM MODEL: AC mode data point (time: $time, voltage: $voltage, current: $current)");
        }
        addDataPoint(time, voltage, current);
        time += 0.1;
        // rxValue-Berechnung auch im AC-Modus
        if (rMax != null) {
          rxValue = (voltage / 3.3) * rMax!;
          if (kDebugMode) print("FROM MODEL: Updated rxValue to $rxValue");
        }
      }
    } else {
      if (kDebugMode) print("FROM MODEL: Unerwartete Datenlänge: ${data.length}");
    }
    notifyListeners();
  }

  void addDataPoint(double timestamp, double voltage, double current) {
    _voltageData.add(FlSpot(timestamp, voltage));
    _currentData.add(FlSpot(timestamp, current));

    if (_voltageData.length > maxDisplayPoints) {
      _voltageData.removeAt(0);
    }
    if (_currentData.length > maxDisplayPoints) {
      _currentData.removeAt(0);
    }
    if (kDebugMode) print("FROM MODEL: Data points updated. Voltage data length: ${_voltageData.length}, Current data length: ${_currentData.length}");
  }

  void clearData() {
    _voltageData.clear();
    _currentData.clear();
    time = 0;
    if (kDebugMode) print("FROM MODEL: Data cleared.");
    notifyListeners();
  }

  void toggleRunningState(BuildContext context) {
    if (isRunning) {
      if (kDebugMode) print("FROM MODEL: Stopping data reception.");
      stopDataReception();
    } else {
      if (kDebugMode) print("FROM MODEL: Starting data reception.");
      startDataReception(context);
    }
  }

  void startDataReception(BuildContext context) {
    if (!BLEManager().isDeviceConnected()) {
      if (kDebugMode) print("FROM MODEL: No device connected. Showing connection dialog.");
      _showConnectionDialog(context);
    } else if (!isRunning) {
      isRunning = true;
      if (kDebugMode) print("FROM MODEL: Device connected. Sending START command.");
      BLEManager().sendCommand("START");

      if (_freqSliderValue == 0) {
        _freqSliderValue = 4.0;
        if (kDebugMode) print("FROM MODEL: Default frequency set to 4.0 Hz to trigger data transmission.");
      }
      sendFrequencyToBLE();
      notifyListeners();
    }
  }


  void _showConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Verbindung erforderlich",
            style: TextStyle(
              color: AppColors.color212121,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Du bist mit keinem Gerät verbunden.",
            style: TextStyle(
              color: AppColors.textColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Abbrechen",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RoutePaths.newScanDeviceViewRoute);
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "Verbinden",
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void stopDataReception() {
    if (isRunning) {
      isRunning = false;
      BLEManager().sendCommand("STOP");
      if (kDebugMode) print("FROM MODEL: Stopped data reception.");
      notifyListeners();
    }
  }

  void resetData() {
    if (kDebugMode) print("FROM MODEL: Resetting data.");
    stopDataReception();
    clearData();
  }

  void updateSliderValue(double newValue) {
    _sliderValue = newValue;
    if (kDebugMode) print("FROM MODEL: Slider value updated to: $_sliderValue");
    notifyListeners();
  }

  void updateFreqSliderValue(double newValue) {
    _freqSliderValue = newValue;
    if (kDebugMode) print("FROM MODEL: Frequency slider value updated to: $_freqSliderValue Hz");
    notifyListeners();
    if (_freqSliderValue > 0) {
      if (kDebugMode) print("FROM MODEL: Sending frequency to BLE: $_freqSliderValue Hz");
      sendFrequencyToBLE();
    } else {
      if (kDebugMode) print("FROM MODEL: Frequency set to zero, stopping frequency updates.");
      BLEManager().sendFrequency(0);
    }
  }

  void sendFrequencyToBLE() {
    if (_freqSliderValue > 0) {
      BLEManager().sendFrequency(_freqSliderValue);
      if (kDebugMode) print("FROM MODEL: Frequency sent to BLE: $_freqSliderValue Hz");
    }
  }

  Future<void> updateRMaxValue(Experiment experiment, String voltage) async {
    if (experiment == Experiment.experiment3 && rMax != null) {
      double uMax = 3.3;
      rxValue = (double.parse(voltage) / uMax) * rMax!;
      if (kDebugMode) print("FROM MODEL: RMax value updated to: $rxValue");
      notifyListeners();
    }
  }

  void setRMax(double rMaxValue) {
    rMax = rMaxValue;
    if (kDebugMode) print("FROM MODEL: Rmax set to $rMaxValue");
  }

  @override
  void dispose() {
    BLEManager().connectionStatus.removeListener(_onConnectionStatusChanged);
    if (kDebugMode) print("FROM MODEL: MeasurementGraphViewModel disposed.");
    super.dispose();
  }
}
