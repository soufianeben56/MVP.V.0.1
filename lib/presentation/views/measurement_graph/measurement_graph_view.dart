import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'package:infinity_circuit/presentation/views/measurement_graph/CustomGraphViewModel.dart';
import 'package:infinity_circuit/presentation/views/measurement_graph/rmax_input.dart';
import 'package:infinity_circuit/presentation/views/measurement_graph/solution_appbar.dart';
import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';
import '../../../generated/l10n.dart';
import '../solution_detail/solution_detail_view.dart';
import '../connect_blue/blue_manager.dart';
import 'CustomGraph.dart';
import 'CustomSeekBar.dart';
import 'measurement_graph_view_model.dart';

class MeasurementGraphView extends StatefulWidget {
  final MeasurementGraphArguments arguments;

  const MeasurementGraphView({super.key, required this.arguments});

  @override
  MeasurementGraphViewState createState() => MeasurementGraphViewState();
}

class MeasurementGraphViewState extends State<MeasurementGraphView> {
  bool showOverlay = true;
  bool _plausibilitySnackbarVisible = false;
  DateTime? _lastPlausibilityError;

  @override
  void initState() {
    super.initState();
    _checkOverlaySeen();
  }

  Future<void> _checkOverlaySeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOverlay = prefs.getBool('hasSeenOverlay') ?? false;
    setState(() {
      showOverlay = !hasSeenOverlay;
    });
  }

  Future<void> _setOverlaySeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOverlay', true);
  }

  void _showPlausibilitySnackbar() {
    if (_plausibilitySnackbarVisible) return;
    _plausibilitySnackbarVisible = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(MeasurementGraphViewModel.plausibilityErrorText),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    ).closed.then((_) {
      _plausibilitySnackbarVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Current experiment: ${widget.arguments.experiment}");
    }

    return ViewModelBuilder<MeasurementGraphViewModel>.reactive(
      viewModelBuilder: () => MeasurementGraphViewModel(experiment: widget.arguments.experiment),
      onViewModelReady: (viewModel) {
        viewModel.onDisconnected = () {
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
        };
        if (viewModel.experiment == Experiment.experiment2) {
          viewModel.onPlausibilityError = () {
            // Die Snackbar wird jetzt nur noch im Dioden-Graph über einen Callback getriggert
            // und nicht mehr direkt hier.
          };
        }
      },
      builder: (context, viewModel, child) {
        return DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: Scaffold(
            backgroundColor: AppColors.primaryBackGroundColor,
            appBar: SolutionAppBar(
              title: S.current.experiments,
              backgroundColor: Colors.transparent,
              onTapAction: () {
                final currentSolutionType = experimentSolutionMap[widget.arguments.experiment];
                if (currentSolutionType != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SolutionDetailView(
                        selectedSolution: currentSolutionType,
                      ),
                    ),
                  );
                }
              },
            ),
            body: Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.relativeHeight(1.97),
                    horizontal: SizeConfig.relativeWidth(4.80),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.4,
                          ),
                        ),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Color(0xFF023059),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                          tabs: [
                            Tab(text: 'Wert'),
                            Tab(text: 'Graph'),
                          ],
                          labelColor: Colors.white,
                          unselectedLabelColor: Color(0xFF212121).withOpacity(0.4),
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            tab1(viewModel, widget.arguments, context),
                            CustomGraph(
                              voltageData: viewModel.voltageData,
                              currentData: viewModel.currentData,
                              hasDiodeGraph: widget.arguments.experiment == Experiment.experiment2,
                              timeInterval: viewModel.sliderValue,
                              selectedUnit: viewModel.selectedUnit,
                              onUnitChanged: viewModel.updateSelectedUnit,
                              plausibilityErrorCallback: () {
                                // Zeige Snackbar nur, wenn Dioden-Graph aktiv ist
                                if (viewModel.selectedGraphType == 'Diode Graph') {
                                  _showPlausibilitySnackbar();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (showOverlay)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showOverlay = false;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.7),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0, right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Transform.rotate(
                                      angle: -3.14159 / 2,
                                      child: Assets.icons.icInfoLine.image(
                                        height: 60,
                                        width: 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Hier finden Sie die Lösung!",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showOverlay = false;
                                      });
                                      _setOverlaySeen();
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Text(
                                      " Verstanden ",
                                      style: TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget homeContainers({
    String title = "",
    String description = "",
    AssetGenImage? assetGenImage,
    double? imgWidth,
    double? imgHeight,
    bool isDescription = true,
  }) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: assetGenImage!
                .image(
              height: SizeConfig.relativeHeight(imgHeight ?? 0),
              width: SizeConfig.relativeWidth(imgWidth ?? 0),
            )
                .wrapPadding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(2.67),
                vertical: SizeConfig.relativeHeight(0.99),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tab1(MeasurementGraphViewModel viewModel, MeasurementGraphArguments arguments, BuildContext context) {
    // Für Versuch 1 (RLC-Schaltung) die erweiterte Ansicht mit RMS und Phasenverschiebung anzeigen
    if (arguments.experiment == Experiment.experiment1) {
      return ValueDisplayTab(viewModel: viewModel, arguments: arguments);
    } 
    // Für Versuch 3 (Brückenschaltungs-Experiment) die Potentiometer-Kalibrierung anzeigen
    else if (arguments.experiment == Experiment.experiment3) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.relativeHeight(2),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Schaltungsbild anzeigen
              Container(
                width: (SizeConfig.screenWidth ?? 300) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (arguments.assetGenImage != null)
                      Center(
                        child: arguments.assetGenImage!.image(
                          height: SizeConfig.relativeHeight(arguments.imgHeight ?? 9.48),
                          width: SizeConfig.relativeWidth(arguments.imgWidth ?? 59.14),
                        ).wrapPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.relativeWidth(2.67),
                            vertical: SizeConfig.relativeHeight(0.99),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Werte-Anzeige für Experiment 3
              Container(
                width: (SizeConfig.screenWidth ?? 300) * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Überschrift
                    Text(
                      "Gemessene Werte",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023059),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Aktuelle Messwerte anzeigen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSimpleValueDisplay(
                          label: "Spannung",
                          value: viewModel.voltageData.isNotEmpty 
                                 ? viewModel.voltageData.last.y.toStringAsFixed(2) 
                                 : "0.00",
                          unit: "V",
                        ),
                        _buildSimpleValueDisplay(
                          label: "Strom",
                          value: viewModel.currentData.isNotEmpty 
                                 ? viewModel.currentData.last.y.toStringAsFixed(4) 
                                 : "0.0000",
                          unit: "A",
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Rmax Button und Refresh Button nebeneinander
                    Row(
                      children: [
                        // Potentiometer-Info Button
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF023059).withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                // Öffnen des RMaxInputDialog
                                showDialog(
                                  context: context,
                                  builder: (context) => RMaxInputDialog(
                                    onRMaxSubmitted: (rMax, rxValue) {
                                      viewModel.setRMax(rMax);
                                      viewModel.rxValue = rxValue;
                                      // Keine automatische Aktualisierung mehr - nur noch manuell
                                      viewModel.notifyListeners();
                                      if (kDebugMode) {
                                        print("rMax set to $rMax, rxValue updated to $rxValue");
                                      }
                                    },
                                    latestVoltage: viewModel.voltageData.isNotEmpty 
                                                 ? viewModel.voltageData.last.y 
                                                 : null,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Color(0xFF023059),
                              ),
                              label: Text(
                                "Potentiometer-Info",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF023059),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                minimumSize: Size(0, 0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Refresh Button - Außerhalb der Dialog-Box
                        Container(
                          width: 50,
                          height: 48, // Match the height of the Potentiometer-Info button
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Aktualisiere den Rx-Wert nur wenn explizit gedrückt
                              if (!BLEManager().isDeviceConnected()) {
                                if (kDebugMode) {
                                  print("Cannot refresh - device not connected");
                                }
                                // Show a short notification to the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Kein Gerät verbunden"),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              
                              if (viewModel.voltageData.isEmpty) {
                                if (kDebugMode) {
                                  print("Cannot refresh - no voltage data available");
                                }
                                // Show a short notification to the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Keine Spannungswerte verfügbar"),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                                return;
                              }
                              
                              if (viewModel.rMax == null) {
                                if (kDebugMode) {
                                  print("Cannot refresh - rMax not set");
                                }
                                // Show a short notification to the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Rmax nicht eingestellt - bitte erst Potentiometer-Info öffnen"),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                                return;
                              }
                              
                              // Alles in Ordnung, aktualisiere den rxValue
                              final double currentVoltage = viewModel.voltageData.last.y;
                              viewModel.updateRxValue(currentVoltage);
                              
                              // Show a success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Rx-Wert aktualisiert: ${viewModel.rxValue.toStringAsFixed(2)} Ω"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              
                              if (kDebugMode) {
                                print("Manual refresh - updated rxValue to ${viewModel.rxValue} using voltage $currentVoltage and rMax ${viewModel.rMax}");
                              }
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.green,
                              size: 24,
                            ),
                            tooltip: "Rx-Wert aktualisieren",
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Berechneter Widerstand (wird direkt vom ViewModel aktualisiert)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Aktueller Widerstand: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF023059),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              viewModel.rxValue > 0 
                                 ? "${viewModel.rxValue.toStringAsFixed(1)} Ω" 
                                 : "Nicht berechnet",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF023059),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } 
    // Für alle anderen Versuche (2, 4) die einfache Ansicht ohne RMS und Phasenverschiebung anzeigen
    else {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.relativeHeight(2),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Schaltungsbild anzeigen
              Container(
                width: (SizeConfig.screenWidth ?? 300) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (arguments.assetGenImage != null)
                      Center(
                        child: arguments.assetGenImage!.image(
                          height: SizeConfig.relativeHeight(arguments.imgHeight ?? 9.48),
                          width: SizeConfig.relativeWidth(arguments.imgWidth ?? 59.14),
                        ).wrapPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.relativeWidth(2.67),
                            vertical: SizeConfig.relativeHeight(0.99),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Einfache Werte-Anzeige für andere Versuche
              Container(
                width: (SizeConfig.screenWidth ?? 300) * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Überschrift
                    Text(
                      "Gemessene Werte",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023059),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Aktuelle Messwerte anzeigen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSimpleValueDisplay(
                          label: "Spannung",
                          value: viewModel.voltageData.isNotEmpty 
                                 ? viewModel.voltageData.last.y.toStringAsFixed(2) 
                                 : "0.00",
                          unit: "V",
                        ),
                        _buildSimpleValueDisplay(
                          label: "Strom",
                          value: viewModel.currentData.isNotEmpty 
                                 ? viewModel.currentData.last.y.toStringAsFixed(4) 
                                 : "0.0000",
                          unit: "A",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // Hilfsmethode für Potentiometer-Anleitung
  Widget _buildPotentiometerStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFF023059),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // Hilfsmethode für die einfache Wertanzeige
  Widget _buildSimpleValueDisplay({
    required String label,
    required String value,
    required String unit,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 4),
            Text(
              unit,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tab2(MeasurementGraphViewModel viewModel, MeasurementGraphArguments arguments, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.relativeHeight(3.20)),
          homeContainers(
            title: stringExpTitle1,
            description: stringExpDescription1New,
            assetGenImage: arguments.assetGenImage,
            imgHeight: arguments.imgHeight,
            imgWidth: arguments.imgWidth,
          ),
          SizedBox(height: SizeConfig.relativeHeight(2.96)),
          CustomGraph(
            key: ValueKey(viewModel.runId),
            voltageData: viewModel.voltageData,
            currentData: viewModel.currentData,
            timeInterval: viewModel.sliderValue,
            hasDiodeGraph: arguments.experiment == Experiment.experiment2 ? true : false,
            selectedUnit: viewModel.selectedUnit,
            onUnitChanged: viewModel.updateSelectedUnit,
          ),
          SizedBox(height: SizeConfig.relativeHeight(2)),
          CommonTextWidget(
            text: " Steuerung",
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.setSp(16),
          ),
          SizedBox(height: SizeConfig.relativeHeight(2)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: 'Zeit',
                      fontSize: SizeConfig.setSp(14),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: SizeConfig.relativeHeight(1.5)),
                    CustomSeekBar(
                      value: viewModel.sliderValue,
                      onChanged: (value) {
                        viewModel.updateSliderValue(value);
                      },
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.relativeHeight(2.5)),
                (arguments.experiment == Experiment.experiment1) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: 'Frequenz:  ${viewModel.freqSliderValue.toStringAsFixed(1)} Hz',
                      fontSize: SizeConfig.setSp(14),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: SizeConfig.relativeHeight(1.5)),
                    SliderTheme(
                      data: SliderThemeData(
                        overlayShape: SliderComponentShape.noOverlay,
                        thumbShape: CustomSliderThumbImage(
                          thumbImage: AssetImage('assets/icons/ic_indicator.png'),
                          height: SizeConfig.relativeHeight(2),
                        ),
                        trackHeight: 3.0,
                        activeTrackColor: AppColors.colorD3,
                        inactiveTrackColor: AppColors.colorD3,
                        activeTickMarkColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent,
                        valueIndicatorColor: AppColors.background,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      child: Slider(
                        value: viewModel.freqSliderValue,
                        min: 0.0,
                        max: 200.0,
                        divisions: 199,
                        label: "  ${viewModel.freqSliderValue.toStringAsFixed(1)} Hz  ",
                        onChanged: (double value) {
                          viewModel.updateFreqSliderValue(value);
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.relativeHeight(3.0)),
                  ],
                ) : SizedBox(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.toggleRunningState(context);
                      },
                      child: Column(
                        children: [
                          (viewModel.isRunning ? Assets.svg.icStopButton : Assets.svg.icPlayButton)
                              .svg(
                            height: SizeConfig.relativeHeight(4.0),
                            width: SizeConfig.relativeWidth(14.81),
                          ),
                          SizedBox(height: SizeConfig.relativeHeight(0.5)),
                          CommonTextWidget(
                            text: viewModel.isRunning ? 'Stoppen' : 'Starten',
                            fontSize: SizeConfig.setSp(10),
                            fontWeight: FontWeight.w600,
                            color: viewModel.isRunning ? AppColors.colorRed : AppColors.colorGreen,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: SizeConfig.relativeWidth(4.0)),
                    GestureDetector(
                      onTap: () {
                        if (viewModel.experiment == Experiment.experiment2) {
                          viewModel.resetData(); // Diode: Stop + clear + RESET_DIODE
                        } else {
                          viewModel.clearData();
                        }
                      },
                      child: Column(
                        children: [
                          Assets.svg.icResetButton.svg(
                            height: SizeConfig.relativeHeight(4.0),
                            width: SizeConfig.relativeWidth(14.81),
                          ),
                          SizedBox(height: SizeConfig.relativeHeight(0.5)),
                          CommonTextWidget(
                            text: 'Zurücksetzen',
                            fontSize: SizeConfig.setSp(10),
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorOrange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.relativeHeight(4.0)),
        ],
      ),
    );
  }

}

// Widget zur Anzeige der gemessenen Werte (RMS U, RMS I, Phase)
class ValueDisplayTab extends StatefulWidget {
  final MeasurementGraphViewModel viewModel;
  final MeasurementGraphArguments arguments;

  const ValueDisplayTab({
    Key? key, 
    required this.viewModel,
    required this.arguments,
  }) : super(key: key);

  @override
  _ValueDisplayTabState createState() => _ValueDisplayTabState();
}

class _ValueDisplayTabState extends State<ValueDisplayTab> {
  late Timer _updateTimer;
  double _displayRmsU = 0.0;
  double _displayRmsI = 0.0;
  double _displayPhase = 0.0;

  @override
  void initState() {
    super.initState();
    
    // Initialisiere die Werte sofort
    _updateDisplayValues();
    
    // Starte den Timer für die periodische Aktualisierung alle 4 Sekunden
    _updateTimer = Timer.periodic(Duration(seconds: 4), (_) {
      _updateDisplayValues();
    });
  }

  @override
  void dispose() {
    // Timer aufräumen, wenn das Widget zerstört wird
    _updateTimer.cancel();
    super.dispose();
  }

  // Aktualisiert die anzuzeigenden Werte
  void _updateDisplayValues() {
    setState(() {
      _displayRmsU = widget.viewModel.lastRmsU;
      _displayRmsI = widget.viewModel.lastRmsI;
      _displayPhase = widget.viewModel.lastPhase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.relativeHeight(2),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Schaltungsbild anzeigen
            Container(
              width: (SizeConfig.screenWidth ?? 300) * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (widget.arguments.assetGenImage != null)
                    Center(
                      child: widget.arguments.assetGenImage!.image(
                        height: SizeConfig.relativeHeight(widget.arguments.imgHeight ?? 9.48),
                        width: SizeConfig.relativeWidth(widget.arguments.imgWidth ?? 59.14),
                      ).wrapPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.relativeWidth(2.67),
                          vertical: SizeConfig.relativeHeight(0.99),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Werte-Anzeige
            Container(
              width: (SizeConfig.screenWidth ?? 300) * 0.9,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Überschrift
                  Text(
                    "Gemessene Werte",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF023059),
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // RMS Spannungswert
                  _buildValueDisplay(
                    icon: Icons.bolt,
                    iconColor: Colors.orange,
                    label: "RMS U",
                    value: _displayRmsU.toStringAsFixed(2),
                    unit: "V",
                  ),
                  SizedBox(height: 20),
                  
                  // RMS Stromwert
                  _buildValueDisplay(
                    icon: Icons.electric_bolt,
                    iconColor: Colors.blue,
                    label: "RMS I",
                    value: _displayRmsI.toStringAsFixed(4),
                    unit: "A",
                  ),
                  SizedBox(height: 20),
                  
                  // Phasenverschiebung
                  _buildValueDisplay(
                    icon: Icons.change_history,
                    iconColor: Colors.purple,
                    label: "φ",
                    value: _displayPhase.toStringAsFixed(1),
                    unit: "°",
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Letzte Aktualisierung
                  Text(
                    "Aktualisierung alle 4 Sekunden",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hilfsmethode zum Aufbau der einzelnen Wertanzeigen
  Widget _buildValueDisplay({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String unit,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}