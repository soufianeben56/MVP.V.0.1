import 'package:fl_chart/fl_chart.dart';
import 'package:infinity_circuit/constants/ble_constants.dart';
import 'package:infinity_circuit/exports.dart';

import '../solution/solution_viewmodel.dart';
import 'measurement_graph_view_model.dart';

///
enum Experiment {
  experiment1,
  experiment2,
  experiment3,
  experiment4,
}

final List<String> experiment1List = ['Frequency'];
final List<String> experiment2List = ['D2', 'D1'];
final List<String> experiment3List = ['R3', 'R4', 'VR1'];
final List<String> experiment4List = [
  'D1',
  'D2',
  'R3',
  'R4',
  'C1',
  'C2',
  'Q1',
  'Q2'
];

final Map<Experiment, List<String>> experimentLists = {
  Experiment.experiment1: experiment1List,
  Experiment.experiment2: experiment2List,
  Experiment.experiment3: experiment3List,
  Experiment.experiment4: experiment4List,
};

final Map<Experiment, SolutionType> experimentSolutionMap = {
  Experiment.experiment1: SolutionType.solution1,
  Experiment.experiment2: SolutionType.solution2,
  Experiment.experiment3: SolutionType.solution3,
  Experiment.experiment4: SolutionType.solution4,
};

class CustomGraphViewModel extends LocalBaseModel {
  // List of FlSpot points for each graph line
  List<FlSpot> voltageSpots = [];
  List<FlSpot> currentSpots = [];
  List<FlSpot> sineWaveSpots = [];
  List<FlSpot> diodeSpots = [];

  double currentFrequency = 10.0; // Default frequency value

  MeasurementGraphViewModel measurementGraphViewModel =
      MeasurementGraphViewModel();

  double time = 1.0; // This will be your X-axis (time) value.

  // Simulating incoming data, in reality, you might get this from a BLE stream or API
  void updateChartData(
      double voltage, double current, int sinewave, double diodeVoltage) {
    // Add new data to each list of FlSpot
    voltageSpots.add(FlSpot(time, voltage));
    currentSpots.add(FlSpot(time, current));
    sineWaveSpots.add(FlSpot(time, sinewave.toDouble()));
    diodeSpots.add(FlSpot(time, diodeVoltage));

    // Increment time or X-axis value for next point
    time += 1.0;

    // Limit number of points to avoid overcrowding (optional)
    if (voltageSpots.length > 10) voltageSpots.removeAt(0);
    if (currentSpots.length > 10) currentSpots.removeAt(0);
    if (sineWaveSpots.length > 10) sineWaveSpots.removeAt(0);
    if (diodeSpots.length > 10) diodeSpots.removeAt(0);

    notifyListeners();
  }

  Experiment? _selectedExperiment = Experiment.experiment1;
  String? _selectedValue;
  List<String> _options = [];

  Experiment? get selectedExperiment => _selectedExperiment;
  String? get selectedValue => _selectedValue;
  List<String> get options => _options;
  double? selectedFrequency;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the stored value from preferences
    _loadCurrentFrequency();
  }

  Future<void> _loadCurrentFrequency() async {
    selectedFrequency =
        UserPreference.getDouble(PrefKeys.currentFrequency, defValue: 10.0) ??
            10.0;

    notifyListeners();
  }

  void setSelectedExperiment(Experiment? experiment) {
    _selectedExperiment = experiment;
    _options = experimentLists[experiment] ?? [];
    _selectedValue = _options.isNotEmpty
        ? _options.first
        : null; // Set default value if available
    notifyListeners();
  }

  void setSelectedValue(String? value) {
    _selectedValue = value;
    notifyListeners();
  }

  Future<void> setSelectedFrequency(double newFrequency) async {
    selectedFrequency = newFrequency;
    notifyListeners();
  }

  bool isReadingData = false; // Flag to track if data reading is active

  Future<void> startReadingData() async {
    // Set the flag to indicate reading is active
    isReadingData = true;

    // Start the timer for periodic BLE data reading
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      List<int> simulatedData = await readCharacteristicFromDeviceId(
        UserPreference.getString(PrefKeys.deviceId) ?? '',
      ); // Replace with real BLE data
    });
  }
}
