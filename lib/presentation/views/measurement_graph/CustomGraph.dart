import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:infinity_circuit/exports.dart';
import 'package:provider/provider.dart';
import 'measurement_graph_view_model.dart';

import '../custom_graphs/diode_graph.dart';

class CustomGraph extends StatefulWidget {
  final List<FlSpot> voltageData;
  final List<FlSpot> currentData;
  final bool hasDiodeGraph;
  final double timeInterval;
  final String selectedUnit;
  final Function(String) onUnitChanged;
  final VoidCallback? plausibilityErrorCallback;

  const CustomGraph({
    super.key,
    required this.voltageData,
    required this.currentData,
    this.hasDiodeGraph = false,
    required this.timeInterval,
    required this.selectedUnit,
    required this.onUnitChanged,
    this.plausibilityErrorCallback,
  });

  @override
  CustomGraphState createState() => CustomGraphState();
}

class CustomGraphState extends State<CustomGraph> {
  final List<String> unitOptions = ['V/A', 'mV/mA'];
  bool showVoltage = true;  // Für andere Experimente
  bool showCurrent = true;  // Für andere Experimente

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MeasurementGraphViewModel>(context);
    final bool isExperiment2 = widget.hasDiodeGraph;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.selectedUnit,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 16,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                items: unitOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: CommonTextWidget(
                        text: value,
                        fontSize: SizeConfig.setSp(11),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    widget.onUnitChanged(newValue);
                  }
                },
              ),
            ),
            if (isExperiment2)
            Container(
              width: 120,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                  value: viewModel.selectedGraphType,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 16,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                  items: ['Voltage Graph', 'Current Graph', 'Diode Graph'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: CommonTextWidget(
                          text: value == 'Voltage Graph' ? 'Spannungsgraph' :
                                value == 'Current Graph' ? 'Stromgraph' :
                                value == 'Diode Graph' ? 'Diodengraph' : value,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.setSp(12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      viewModel.updateSelectedGraphType(newValue);
                    }
                  },
                ),
              )
            else
              Row(
                children: [
                  _buildToggleSwitch("Voltage", AppColors.colorDarkBlue, showVoltage, (value) {
                    setState(() {
                      showVoltage = value;
                    });
                  }),
                  SizedBox(width: 12),
                  _buildToggleSwitch("Current", AppColors.colorGreen, showCurrent, (value) {
                    setState(() {
                      showCurrent = value;
                    });
                  }),
                ],
            ),
          ],
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
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(15),
          child: SizedBox(
            height: 400,
            child: _buildGraph(),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSwitch(String label, Color color, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        CommonTextWidget(
          text: label,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.setSp(12),
        ),
        SizedBox(width: 4),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }

  Widget _buildGraph() {
    final viewModel = Provider.of<MeasurementGraphViewModel>(context);
    
    if (widget.hasDiodeGraph) {
      // Experiment 2: Verwende das Dropdown-Menü
      switch (viewModel.selectedGraphType) {
        case 'Voltage Graph':
          return _buildSingleGraph(
            data: widget.voltageData,
            color: AppColors.colorDarkBlue,
            title: "Spannung",
            isVoltage: true
          );
        case 'Current Graph':
          return _buildSingleGraph(
            data: widget.currentData,
            color: AppColors.colorGreen,
            title: "Strom",
            isVoltage: false
          );
        case 'Diode Graph':
          // Plausibilitätsfehler-Callback für Snackbar
          viewModel.onPlausibilityError = () {
            if (widget.plausibilityErrorCallback != null) {
              widget.plausibilityErrorCallback!();
            }
          };
          final voltageList = widget.voltageData.isNotEmpty
              ? widget.voltageData.map((spot) => spot.y).toList()
              : [0.0];
          final currentList = widget.currentData.isNotEmpty
              ? widget.currentData.map((spot) => spot.y).toList()
              : [0.0];
          final lastIndex = voltageList.length - 1;
          final lastV = voltageList.isNotEmpty ? voltageList[lastIndex] : 0.0;
          final lastI = currentList.isNotEmpty ? currentList[lastIndex] : 0.0;
          final isLive = viewModel.isRunning && (widget.voltageData.length > 1 ? (widget.voltageData.last.x - widget.voltageData[widget.voltageData.length-2].x) < 1.5 : true);
          return Stack(
            children: [
              DiodeGraph(
                key: ValueKey('diode_graph_${Provider.of<MeasurementGraphViewModel>(context).runId}'),
                voltageData: voltageList,
                currentData: currentList,
              ),
              // Legend oben rechts mit Statuspunkt
              Positioned(
                top: 8,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isLive ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black26, width: 1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'I(U) Diode – Echtzeit',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              // Skalen-Overlay für letzten Punkt
              if (voltageList.isNotEmpty && currentList.isNotEmpty)
                Positioned(
                  left: 24,
                  bottom: 32,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'U = ${lastV.toStringAsFixed(2)} V',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'I = ${(lastI * 1000).toStringAsFixed(1)} mA',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              // TODO: Tooltip overlay for DiodeGraph
            ],
          );
        default:
          return _buildSingleGraph(
            data: widget.voltageData,
            color: AppColors.colorDarkBlue,
            title: "Spannung",
            isVoltage: true
          );
      }
    }

    // Andere Experimente: Verwende Toggle-Switches
    if (!showVoltage && !showCurrent) {
      return _buildEmptyGraph();
    }

    double voltageScalingFactor = widget.selectedUnit == 'mV/mA' ? 1000.0 : 1.0;
    double currentScalingFactor = widget.selectedUnit == 'mV/mA' ? 1000.0 : 1.0;
    String voltageUnitSuffix = widget.selectedUnit == 'mV/mA' ? "mV" : "V";
    String currentUnitSuffix = widget.selectedUnit == 'mV/mA' ? "mA" : "A";

    final filteredVoltageData = _filterData(widget.voltageData);
    final filteredCurrentData = _filterData(widget.currentData);
    
    final scaledVoltageData = filteredVoltageData.map((spot) {
      return FlSpot(spot.x, spot.y * voltageScalingFactor);
    }).toList();
    
    final scaledCurrentData = filteredCurrentData.map((spot) {
      return FlSpot(spot.x, spot.y * currentScalingFactor);
    }).toList();

    final allData = <FlSpot>[];
    if (showVoltage) allData.addAll(scaledVoltageData);
    if (showCurrent) allData.addAll(scaledCurrentData);

    // Wenn keine Daten vorhanden, zeige einen leeren Graphen
    if (allData.isEmpty) {
      return _buildEmptyGraph();
    }

    final minX = allData.map((spot) => spot.x).reduce(min);
    final maxX = allData.map((spot) => spot.x).reduce(max);
    final minY = allData.map((spot) => spot.y).reduce(min);
    final maxY = allData.map((spot) => spot.y).reduce(max);
    
    double adjustedMinY;
    double adjustedMaxY;
    
    if (widget.selectedUnit == 'V/A') {
      double defaultMinY = -1.7;
      double defaultMaxY = 1.7;

      adjustedMinY = min(minY, defaultMinY);
      adjustedMaxY = max(maxY, defaultMaxY);
      
      if (adjustedMinY == defaultMinY && adjustedMaxY == defaultMaxY) {
         adjustedMinY -= 0.1;
         adjustedMaxY += 0.1;
      } else {
         final range = adjustedMaxY - adjustedMinY;
         adjustedMinY -= range * 0.1;
         adjustedMaxY += range * 0.1;
      }
    } else {
      double range = maxY - minY;
      if (range < 1e-9) {
        adjustedMinY = minY - 0.5;
        adjustedMaxY = maxY + 0.5;
      } else {
        adjustedMinY = minY - range * 0.1;
        adjustedMaxY = maxY + range * 0.1;
      }
    }

    // Stelle sicher, dass verticalInterval nie 0 sein kann
    double verticalInterval = (maxX - minX) / 5;
    if (verticalInterval.isNaN || verticalInterval <= 0) {
      verticalInterval = 0.01; // Minimalwert für fl_chart
    }

    // Stelle sicher, dass horizontalInterval nie 0 sein kann
    double horizontalInterval = (adjustedMaxY - adjustedMinY) / 5;
    if (horizontalInterval.isNaN || horizontalInterval <= 0) {
      horizontalInterval = 0.01; // Minimalwert für fl_chart
    }

    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: adjustedMinY,
        maxY: adjustedMaxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: horizontalInterval,
          verticalInterval: verticalInterval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.black.withOpacity(0.1),
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: AppColors.black.withOpacity(0.1),
            strokeWidth: 0.5,
          ),
        ),
        lineBarsData: [
          if (showVoltage)
            LineChartBarData(
              spots: scaledVoltageData,
              isCurved: true,
              color: AppColors.colorDarkBlue,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          if (showCurrent)
            LineChartBarData(
              spots: scaledCurrentData,
              isCurved: true,
              color: AppColors.colorGreen,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.black.withOpacity(0.1), width: 0.5),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            axisNameWidget: Align(
              alignment: Alignment.bottomRight,
              child: CommonTextWidget(
                text: "Zeit (s)",
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.setSp(10),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              interval: (maxX - minX) / 5,
              getTitlesWidget: (value, meta) {
                if (value == meta.min) return SizedBox.shrink();
                return CommonTextWidget(
                  text: value.toStringAsFixed(1),
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.setSp(10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            axisNameWidget: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: CommonTextWidget(
                  text: _getYAxisTitle(voltageUnitSuffix, currentUnitSuffix),
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.setSp(10),
                ),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              interval: (adjustedMaxY - adjustedMinY) / 5,
              getTitlesWidget: (value, meta) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: CommonTextWidget(
                      text: value.toStringAsFixed(2),
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.setSp(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 2,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            tooltipMargin: 2,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final bool isVoltage = touchedSpot.bar.color == AppColors.colorDarkBlue;
                return LineTooltipItem(
                  '${touchedSpot.x.toStringAsFixed(2)} s\n${touchedSpot.y.toStringAsFixed(2)} ${isVoltage ? voltageUnitSuffix : currentUnitSuffix}',
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
      ),
    );
  }

  String _getYAxisTitle(String voltageUnit, String currentUnit) {
    if (showVoltage && showCurrent) {
      return "Spannung ($voltageUnit) / Strom ($currentUnit)";
    } else if (showVoltage) {
      return "Spannung ($voltageUnit)";
    } else {
      return "Strom ($currentUnit)";
    }
  }

  Widget _buildSingleGraph({
    required List<FlSpot> data,
    required Color color,
    required String title,
    required bool isVoltage
  }) {
    // Wenn keine Daten vorhanden, zeige einen leeren Graphen
    if (data.isEmpty) {
      return _buildEmptyGraph();
    }

    double scalingFactor = widget.selectedUnit == 'mV/mA' ? 1000.0 : 1.0;
    String unitSuffix = isVoltage 
        ? (widget.selectedUnit == 'mV/mA' ? "mV" : "V")
        : (widget.selectedUnit == 'mV/mA' ? "mA" : "A");

    final scaledData = data.map((spot) {
      return FlSpot(spot.x, spot.y * scalingFactor);
    }).toList();

    final minX = scaledData.map((spot) => spot.x).reduce(min);
    final maxX = scaledData.map((spot) => spot.x).reduce(max);
    final minY = scaledData.map((spot) => spot.y).reduce(min);
    final maxY = scaledData.map((spot) => spot.y).reduce(max);
    
    double adjustedMinY;
    double adjustedMaxY;
    
    if (widget.selectedUnit == 'V/A') {
      double defaultMinY = -1.7;
      double defaultMaxY = 1.7;

      adjustedMinY = min(minY, defaultMinY);
      adjustedMaxY = max(maxY, defaultMaxY);
      
      if (adjustedMinY == defaultMinY && adjustedMaxY == defaultMaxY) {
         adjustedMinY -= 0.1;
         adjustedMaxY += 0.1;
      } else {
         final range = adjustedMaxY - adjustedMinY;
         adjustedMinY -= range * 0.1;
         adjustedMaxY += range * 0.1;
      }
    } else {
      double range = maxY - minY;
      if (range < 1e-9) {
        adjustedMinY = minY - 0.5;
        adjustedMaxY = maxY + 0.5;
      } else {
        adjustedMinY = minY - range * 0.1;
        adjustedMaxY = maxY + range * 0.1;
      }
    }

    // Stelle sicher, dass verticalInterval nie 0 sein kann
    double verticalInterval = (maxX - minX) / 5;
    if (verticalInterval.isNaN || verticalInterval <= 0) {
      verticalInterval = 0.01; // Minimalwert für fl_chart
    }

    // Stelle sicher, dass horizontalInterval nie 0 sein kann
    double horizontalInterval = (adjustedMaxY - adjustedMinY) / 5;
    if (horizontalInterval.isNaN || horizontalInterval <= 0) {
      horizontalInterval = 0.01; // Minimalwert für fl_chart
    }

    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: adjustedMinY,
        maxY: adjustedMaxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: horizontalInterval,
          verticalInterval: verticalInterval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.black.withOpacity(0.1),
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: AppColors.black.withOpacity(0.1),
            strokeWidth: 0.5,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: scaledData,
            isCurved: true,
            color: color,
            barWidth: 2,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.black.withOpacity(0.1), width: 0.5),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            axisNameWidget: Align(
              alignment: Alignment.bottomRight,
              child: CommonTextWidget(
                text: "Zeit (s)",
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.setSp(10),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              interval: (maxX - minX) / 5,
              getTitlesWidget: (value, meta) {
                if (value == meta.min) return SizedBox.shrink();
                return CommonTextWidget(
                  text: value.toStringAsFixed(1),
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.setSp(10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            axisNameWidget: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: CommonTextWidget(
                  text: "$title ($unitSuffix)",
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.setSp(10),
                ),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              interval: (adjustedMaxY - adjustedMinY) / 5,
              getTitlesWidget: (value, meta) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: CommonTextWidget(
                      text: value.toStringAsFixed(2),
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.setSp(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 2,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            tooltipMargin: 2,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                return LineTooltipItem(
                  '${touchedSpot.x.toStringAsFixed(2)} s\n${touchedSpot.y.toStringAsFixed(2)} $unitSuffix',
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
      ),
    );
  }

  Widget _buildEmptyGraph() {
    final minX = 0.0;
    final maxX = widget.timeInterval > 0 ? widget.timeInterval : 10.0; // Standardwert wenn timeInterval 0 ist
    final minY = -1.7;
    final maxY = 1.7;

    // Stelle sicher, dass verticalInterval nie 0 sein kann
    double verticalInterval = (maxX - minX) / 5;
    if (verticalInterval.isNaN || verticalInterval <= 0) {
      verticalInterval = 0.01; // Minimalwert für fl_chart
    }

    // Stelle sicher, dass horizontalInterval nie 0 sein kann
    double horizontalInterval = (maxY - minY) / 5;
    if (horizontalInterval.isNaN || horizontalInterval <= 0) {
      horizontalInterval = 0.01; // Minimalwert für fl_chart
    }
    
    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: horizontalInterval,
          verticalInterval: verticalInterval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.black.withOpacity(0.1),
            strokeWidth: 0.5,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: AppColors.black.withOpacity(0.1),
            strokeWidth: 0.5,
          ),
        ),
        lineBarsData: [], // No data to display
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.black.withOpacity(0.1), width: 0.5),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            axisNameWidget: Align(
              alignment: Alignment.bottomRight,
              child: CommonTextWidget(
                text: "Zeit (s)",
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.setSp(10),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              interval: (maxX - minX) / 5,
              getTitlesWidget: (value, meta) {
                if (value == meta.min) return SizedBox.shrink();
                return CommonTextWidget(
                  text: value.toStringAsFixed(1),
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.setSp(10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            axisNameWidget: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: CommonTextWidget(
                  text: widget.selectedUnit,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.setSp(10),
                ),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              interval: (maxY - minY) / 5,
              getTitlesWidget: (value, meta) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: CommonTextWidget(
                      text: value.toStringAsFixed(2),
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.setSp(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _filterData(List<FlSpot> data) {
    final maxX = data.isNotEmpty ? data.last.x : 0.0;
    final minX = (maxX - widget.timeInterval).clamp(0.0, maxX);
    return data.where((spot) => spot.x >= minX && spot.x <= maxX).toList();
  }
}
