import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:collection'; // Für ListQueue
import '../../../service/routing/route_paths.dart';
import '../../../ui/app_colors.dart';
import '../connect_blue/blue_manager.dart';
import 'CustomGraphViewModel.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import '../../../analyze/ble_packet_parser.dart';
import '../../../analyze/fft_analyzer.dart';
import 'dart:math' as math;

class MeasurementGraphViewModel extends ChangeNotifier {
  final List<FlSpot> _voltageData = [];
  final List<FlSpot> _currentData = [];
  double _sliderValue = 5;
  double _freqSliderValue = 0;
  double time = 0;
  bool isRunning = false;
  final int maxDisplayPoints = 100;
  double rxValue = 0;
  double? rMax;
  final Experiment? experiment;
  int runId = 0; // Counter for forcing graph rebuilds

  // Für automatische Offset-Korrektur
  bool autoCenterSignal = true; // Nur für Experiment 1
  final ListQueue<double> _voltageBuffer = ListQueue<double>(200); // Ringpuffer für Spannung
  final ListQueue<double> _currentBuffer = ListQueue<double>(200); // Ringpuffer für Strom
  double _voltageOffset = 0.0;
  double _currentOffset = 0.0;
  int _sampleCounter = 0; // Zähler für Performance-Optimierung

  // New values for AC measurement
  double _lastRmsU = 0.0;
  double _lastRmsI = 0.0;
  double _lastPhase = 0.0;
  
  // Getter for AC measurement values
  double get lastRmsU => _lastRmsU;
  double get lastRmsI => experiment == Experiment.experiment1 ? _lastRmsI / 5.0 : _lastRmsI;
  double get lastPhase => _lastPhase;

  // Sampling Intervall in Millisekunden
  final double samplingIntervalMs = 0.1;

  Function()? onDisconnected;

  // Add state for selected unit
  String _selectedUnit = 'V/A';
  String get selectedUnit => _selectedUnit;
  
  // Add state for selected graph type (for experiment 2)
  String _selectedGraphType = 'Voltage Graph';
  String get selectedGraphType => _selectedGraphType;

  List<FlSpot> get voltageData => _voltageData;
  List<FlSpot> get currentData => _currentData;
  double get sliderValue => _sliderValue;
  double get freqSliderValue => _freqSliderValue;

  Timer? _debounceTimer;
  final Duration _debounceDuration = const Duration(milliseconds: 300);

  // Callback for plausibility error (for SnackBar in UI)
  void Function()? onPlausibilityError;

  static const String plausibilityErrorText =
      'Messwerte außerhalb des Bereichs – bitte Verdrahtung prüfen.';

  MeasurementGraphViewModel({this.experiment}) {
    BLEManager().dataCallback = onDataReceived;
    BLEManager().connectionStatus.addListener(_onConnectionStatusChanged);
    
    // Für Experiment 2 (Dioden) als Standard den DiodeGraph anzeigen
    if (experiment == Experiment.experiment2) {
      _selectedGraphType = 'Diode Graph';
    }
    
    if (kDebugMode) print("FROM MODEL: MeasurementGraphViewModel initialized with experiment: $experiment");
    notifyListeners();
  }

  // Helper-Methode zur Berechnung des Offset-Werts
  void _updateOffsets() {
    // Nur für Experiment 1 und wenn genügend Daten vorhanden sind
    if (experiment == Experiment.experiment1 && autoCenterSignal) {
      // Erst berechnen, wenn genügend Datenpunkte vorhanden sind
      if (_voltageBuffer.length >= 50) {
        double minVoltage = _voltageBuffer.reduce((a, b) => a < b ? a : b);
        double maxVoltage = _voltageBuffer.reduce((a, b) => a > b ? a : b);
        double newVoltageOffset = (minVoltage + maxVoltage) / 2;
        
        // Gewichtete Glättung (80% neuer Wert, 20% alter Wert),
        // aber nur wenn der alte Wert nicht 0 ist (Anfangsbedingung)
        if (_voltageOffset != 0.0) {
          _voltageOffset = 0.8 * newVoltageOffset + 0.2 * _voltageOffset;
        } else {
          _voltageOffset = newVoltageOffset;
        }
        
        if (kDebugMode) {
          print("FROM MODEL: Min Voltage: $minVoltage, Max Voltage: $maxVoltage");
          print("FROM MODEL: Voltage offset updated: $_voltageOffset");
        }
      }

      if (_currentBuffer.length >= 50) {
        double minCurrent = _currentBuffer.reduce((a, b) => a < b ? a : b);
        double maxCurrent = _currentBuffer.reduce((a, b) => a > b ? a : b);
        double newCurrentOffset = (minCurrent + maxCurrent) / 2;
        
        // Gewichtete Glättung (80% neuer Wert, 20% alter Wert)
        if (_currentOffset != 0.0) {
          _currentOffset = 0.8 * newCurrentOffset + 0.2 * _currentOffset;
        } else {
          _currentOffset = newCurrentOffset;
        }
        
        if (kDebugMode) {
          print("FROM MODEL: Min Current: $minCurrent, Max Current: $maxCurrent");
          print("FROM MODEL: Current offset updated: $_currentOffset");
        }
      }
    }
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
    if (kDebugMode) {
      print("FROM MODEL: Data received: $data");
      if (experiment == Experiment.experiment2) {
        print("FROM MODEL: DIODE EXPERIMENT - Data length: ${data.length}");
      }
    }
    
    // DC-Mode: Nur 4 Bytes (2 Bytes Spannung + 2 Bytes Strom)
    if (data.length == 4) {
      ByteData byteData = ByteData.sublistView(data);
      int voltageRaw = byteData.getInt16(0, Endian.little);
      int currentRaw = byteData.getUint16(2, Endian.little);
      double voltage = voltageRaw / 100.0;
      double current = currentRaw / 10000.0;
      
      // Kalibrierung für Experiment 1 (5 Ohm Shunt)
      // (Diese Kalibrierung wird auch in addDataPoint für AC-Modus angewendet)

      // --- Plausibilitäts-Check und Sweep-Reset für Diode-Experiment ---
      if (experiment == Experiment.experiment2) {
        if (!_isPlausible(voltage, current)) {
          if (onPlausibilityError != null) onPlausibilityError!();
          return;
        }
        if (_isNewSweep(voltage)) {
          clearData();
          time = 0;
        }
      }
      // --- Ende Plausibilitäts-Check ---
      addDataPoint(time, voltage, current);
      time += samplingIntervalMs;
      
      // rxValue-Berechnung entfernt - soll nur noch manuell aktualisiert werden
      
      notifyListeners();
      return;
    }
    
    // AC-Mode (mit oder ohne Header): Versuche mit neuem Parser zu parsen
    final parsedBlock = BlePacketParser.parse(data);
    
    if (parsedBlock != null) {
      // Zwischenspeicher für die zentrierten Daten
      final List<double> centeredVoltSamples = [];
      final List<double> centeredCurrSamples = [];
      
      // Add all samples to voltage and current data for display
      for (int i = 0; i < parsedBlock.voltSamples.length; i++) {
        double voltage = parsedBlock.voltSamples[i];
        double current = parsedBlock.currSamples[i];
        
        // Apply offset correction if needed
        if (experiment == Experiment.experiment1 && autoCenterSignal) {
          // Buffer management
          if (_voltageBuffer.length >= 200) _voltageBuffer.removeFirst();
          if (_currentBuffer.length >= 200) _currentBuffer.removeFirst();
          
          _voltageBuffer.add(voltage);
          _currentBuffer.add(current);
          
          // Performance optimization
          _sampleCounter++;
          if (_sampleCounter >= 10) {
            _updateOffsets();
            _sampleCounter = 0;
          }
          
          // Apply offset
          voltage -= _voltageOffset;
          current -= _currentOffset;
        }
        
        // --- Plausibilitäts-Check und Sweep-Reset für Diode-Experiment ---
        if (experiment == Experiment.experiment2) {
          if (!_isPlausible(voltage, current)) {
            if (onPlausibilityError != null) onPlausibilityError!();
            continue;
          }
          if (_isNewSweep(voltage)) {
            clearData();
            time = 0;
          }
        }
        // --- Ende Plausibilitäts-Check ---
        
        // Speichere die zentrierten Werte für RMS- und Phasenberechnung
        centeredVoltSamples.add(voltage);
        centeredCurrSamples.add(current);
        
        addDataPoint(time, voltage, current);
        time += samplingIntervalMs;
        
        // rxValue calculation removed - soll nur noch manuell aktualisiert werden
      }
      
      // Jetzt berechnen wir die RMS-Werte aus den zentrierten Daten
      _lastRmsU = _calculateRMS(centeredVoltSamples);
      _lastRmsI = _calculateRMS(centeredCurrSamples);
      
      // Compute phase angle using FFT analyzer with centered data
      try {
        _lastPhase = FftAnalyzer.computePhaseDeg(
          centeredVoltSamples, 
          centeredCurrSamples
        );
        
        if (kDebugMode) {
          print("FROM MODEL: Sequence: ${parsedBlock.sequence}, RMS U: $_lastRmsU V, RMS I: $_lastRmsI A, Phase: $_lastPhase°");
          print("FROM MODEL: Using frequency: $_freqSliderValue Hz");
        }
      } catch (e) {
        if (kDebugMode) {
          print("FROM MODEL: Error computing phase: $e");
        }
      }
      
      notifyListeners();
      return;
    }
    
    // Wenn wir hier ankommen, haben wir ein unerwartetes Datenformat
    if (kDebugMode) {
      print("FROM MODEL: Unerwartete Datenlänge oder Format: ${data.length}");
    }
    notifyListeners();
  }

  void addDataPoint(double timestamp, double voltage, double current) {
    // Für Experiment 1 (RLC): Strom durch 5 teilen, da 5 Ohm Shunt verwendet wird
    if (experiment == Experiment.experiment1) {
      current = current / 5.0;  // Kalibrierung für 5 Ohm Shunt
    }
    
    _voltageData.add(FlSpot(timestamp, voltage));
    _currentData.add(FlSpot(timestamp, current));

    // For diode experiment (experiment2), keep all data points
    if (experiment != Experiment.experiment2) {
    if (_voltageData.length > maxDisplayPoints) {
      _voltageData.removeAt(0);
    }
    if (_currentData.length > maxDisplayPoints) {
      _currentData.removeAt(0);
      }
    }
    if (kDebugMode) print("FROM MODEL: Data points updated. Voltage data length: ${_voltageData.length}, Current data length: ${_currentData.length}");
  }

  void clearData() {
    _voltageData.clear();
    _currentData.clear();
    // Auch die Puffer zurücksetzen
    _voltageBuffer.clear();
    _currentBuffer.clear();
    _voltageOffset = 0.0;
    _currentOffset = 0.0;
    _sampleCounter = 0;
    
    time = 0;
    if (kDebugMode) print("FROM MODEL: Data cleared.");
    notifyListeners();
  }

  void toggleRunningState(BuildContext context) {
    if (isRunning) {
      if (kDebugMode) print("FROM MODEL: Stopping data reception.");
      stopDataReception();
    } else {
      // Doppelt-Start verhindern: Vor Start Daten löschen, falls vorhanden
      if (experiment == Experiment.experiment2 && _voltageData.isNotEmpty) clearData();
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
      if (experiment == Experiment.experiment2) {
        BLEManager().sendCommand("START_DIODE");
        runId++; // Increment runId to force DiodeGraph rebuild
      } else {
        BLEManager().sendCommand("START");
      }

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
            "Bitte das Gerät verbinden",
            style: TextStyle(
              color: AppColors.color212121,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Um eine Messung zu starten, verbinde bitte zuerst ein Gerät über das Bluetooth-Symbol in der App-Leiste.",
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
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "OK",
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
      if (experiment == Experiment.experiment2) {
        BLEManager().sendCommand("STOP_DIODE");
      } else {
        BLEManager().sendCommand("STOP");
      }
      if (kDebugMode) print("FROM MODEL: Stopped data reception.");
      notifyListeners();
    }
  }

  void resetData() {
    if (kDebugMode) print("FROM MODEL: Resetting data.");
    if (experiment == Experiment.experiment2) {
      BLEManager().sendCommand("RESET_DIODE");
    }
    stopDataReception();
    clearData();
  }

  void updateSliderValue(double newValue) {
    _sliderValue = newValue.clamp(1, 10).roundToDouble();
    if (kDebugMode) print("FROM MODEL: Slider value updated to: $_sliderValue ms");
    notifyListeners();
  }

  void updateFreqSliderValue(double value) {
    _freqSliderValue = value;
    notifyListeners();

    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      if (BLEManager().isDeviceConnected()) {
        sendFrequencyToBLE();
      } else {
        if (kDebugMode) {
          print("FROM MODEL (debounce): Device reported as disconnected. Triggering dialog.");
        }
        onDisconnected?.call();
      }
    });
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

  // Add method to update selected unit
  void updateSelectedUnit(String newUnit) {
    _selectedUnit = newUnit;
    if (kDebugMode) print("FROM MODEL: Selected unit updated to: $_selectedUnit");
    notifyListeners();
  }

  // Add method to update selected graph type
  void updateSelectedGraphType(String newGraphType) {
    _selectedGraphType = newGraphType;
    if (kDebugMode) print("FROM MODEL: Selected graph type updated to: $_selectedGraphType");
    notifyListeners();
  }

  // Hilfsfunktion zur Berechnung des RMS-Werts aus einer Liste von Samples
  double _calculateRMS(List<double> samples) {
    if (samples.isEmpty) return 0.0;
    
    double sumOfSquares = 0.0;
    for (double sample in samples) {
      sumOfSquares += sample * sample;
    }
    
    return math.sqrt(sumOfSquares / samples.length);
  }

  // Methode zum Aktualisieren des rxValue direkt mit einem Spannungswert
  void updateRxValue(double currentVoltage) {
    if (rMax != null) {
      const double uMax = 3.3; // Maximum voltage (3.3V)
      rxValue = (currentVoltage / uMax) * rMax!;
      if (kDebugMode) print("FROM MODEL: Updated rxValue to $rxValue based on voltage $currentVoltage and rMax $rMax");
      notifyListeners();
    } else {
      if (kDebugMode) print("FROM MODEL: Cannot update rxValue - rMax is not set");
    }
  }

  // 1. Hilfsfunktionen für Plausibilität und Sweep-Erkennung
  bool _isPlausible(double u, double i) =>
      u >= 0.0 && u <= 3.4 && i >= 0.0 && i <= 0.10;

  bool _isNewSweep(double u) =>
      experiment == Experiment.experiment2 &&
      _voltageData.isNotEmpty &&
      u < _voltageData.last.y - 0.05;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    BLEManager().connectionStatus.removeListener(_onConnectionStatusChanged);
    if (kDebugMode) print("FROM MODEL: MeasurementGraphViewModel disposed.");
    super.dispose();
  }
}
