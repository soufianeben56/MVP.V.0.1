import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:infinity_circuit/presentation/views/measurement_graph/measurement_graph_view_model.dart';

class GraphTestTwo extends StatelessWidget {
  final MeasurementGraphViewModel viewModel;

  const GraphTestTwo({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    List<FlSpot> voltageData = viewModel.voltageData.cast<FlSpot>();
    List<FlSpot> currentData = viewModel.currentData.cast<FlSpot>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Voltage Graph'),
          Container(
            height: 300,
            width: 400,
            padding: EdgeInsets.all(16),
            child: CustomGraphTest(
              data: voltageData,
              title: 'Voltage (V)',
              maxY: 1000.0,
            ),
          ),
          SizedBox(height: 20),
          Text('Current Graph'),
          Container(
            height: 300,
            width: 400,
            padding: EdgeInsets.all(16),
            child: CustomGraphTest(
              data: currentData,
              title: 'Current (A)',
              maxY: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomGraphTest extends StatelessWidget {
  final List<FlSpot> data;
  final String title;
  final double maxY;

  CustomGraphTest({required this.data, required this.title, required this.maxY});

  @override
  Widget build(BuildContext context) {
    print("Building graph for $title with ${data.length} data points.");

    return LineChart(
      LineChartData(
        maxY: maxY,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${value.toInt()}s',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(
                    '${value.toInt()}',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                    textAlign: TextAlign.end,
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            barWidth: 2,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
