import 'package:flutter/material.dart';
import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';

import '../../../constants/app_constants.dart';
import '../../../generated/assets.gen.dart';
import 'package:infinity_circuit/service/base_model/base_model.dart';
import 'package:infinity_circuit/service/routing/route_paths.dart';

import '../../../local/pref_keys.dart';
import '../../../local/user_preference.dart';
import '../measurement_graph/CustomGraphViewModel.dart';
import '../connect_blue/blue_manager.dart';
import '../../../ui/app_colors.dart';

class HomeExperimentsViewModel extends LocalBaseModel {
  String? registeredName;
  TextEditingController searchController = TextEditingController();

  // Initialize with all experiments
  final List<Map<String, dynamic>> experimentData = [
    {
      "title": stringExpTitle1,
      "description": stringExpDescription1New,
      "assetGenImage": Assets.icons.imgCircuit1New,
      "imgHeight": 15.0,
      "imgWidth": 63.0,
      "onTap": (HomeExperimentsViewModel model) => model.onTapExperiments1(
            MeasurementGraphArguments(
              assetGenImage: Assets.icons.imgCircuit1New,
              imgHeight: 9.48,
              imgWidth: 59.14,
              experiment: Experiment.experiment1,
            ),
          ),
    },
    {
      "title": stringExpTitle2,
      "description": stringExpDescription2,
      "assetGenImage": Assets.icons.imgCircuit2New,
      "imgHeight": 15.0,
      "imgWidth": 60.0,
      "onTap": (HomeExperimentsViewModel model) => model.onTapExperiments2(
            MeasurementGraphArguments(
              assetGenImage: Assets.icons.imgCircuit2New,
              imgHeight: 13.48,
              imgWidth: 45.33,
              experiment: Experiment.experiment2,
            ),
          ),
    },
    {
      "title": stringExpTitle3,
      "description": stringExpDescription3,
      "assetGenImage": Assets.icons.imgCircuit3,
      "imgHeight": 15.75,
      "imgWidth": 56.27,
      "onTap": (HomeExperimentsViewModel model) => model.onTapExperiments3(
            MeasurementGraphArguments(
              assetGenImage: Assets.icons.imgCircuit3,
              imgHeight: 15.75,
              imgWidth: 56.27,
              experiment: Experiment.experiment3,
            ),
          ),
    },
    {
      "title": stringExpTitle4,
      "description": "Untersuchung eines astabilen Multivibrators mit zwei Transistoren und LEDs",
      "assetGenImage": Assets.icons.imgCircuit4,
      "imgHeight": 20.81,
      "imgWidth": 59.87,
      "onTap": (HomeExperimentsViewModel model) => model.onTapExperiments4(
            MeasurementGraphArguments(
              assetGenImage: Assets.icons.imgCircuit4,
              imgHeight: 20.81,
              imgWidth: 59.87,
              experiment: Experiment.experiment4,
            ),
          ),
    },
  ];

  // This list will hold the filtered experiments after search
  List<Map<String, dynamic>> filteredExperiments = [];

  // Constructor
  HomeExperimentsViewModel() {
    // Initialize filtered list with all experiments
    filteredExperiments = experimentData;

    // Add listener to the search controller
    searchController.addListener(() {
      filterExperiments(searchController.text);
    });
  }

  @override
  void onInit() {
    // Fetch the registered name from preferences
    registeredName = UserPreference.getString(PrefKeys.name);

    // Notify the UI to update
    notifyListeners();
    super.onInit();
  }

  // Dispose of the controller to prevent memory leaks
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method for handling navigation when experiments are tapped
  void onTapExperiments1(MeasurementGraphArguments arguments) {
    // Überprüfen, ob ein Gerät verbunden ist
    if (!BLEManager().isDeviceConnected()) {
      // Wir übergeben den BuildContext später in der View
      return;
    }
    navigateTo(RoutePaths.experimentsDetailView1Route, arguments: arguments);
  }

  void onTapExperiments2(MeasurementGraphArguments arguments) {
    // Überprüfen, ob ein Gerät verbunden ist
    if (!BLEManager().isDeviceConnected()) {
      // Wir übergeben den BuildContext später in der View
      return;
    }
    navigateTo(RoutePaths.experimentsDetailView2Route, arguments: arguments);
  }

  void onTapExperiments3(MeasurementGraphArguments arguments) {
    // Überprüfen, ob ein Gerät verbunden ist
    if (!BLEManager().isDeviceConnected()) {
      // Wir übergeben den BuildContext später in der View
      return;
    }
    navigateTo(RoutePaths.experimentsDetailView3Route, arguments: arguments);
  }

  void onTapExperiments4(MeasurementGraphArguments arguments) {
    // Überprüfen, ob ein Gerät verbunden ist
    if (!BLEManager().isDeviceConnected()) {
      // Wir übergeben den BuildContext später in der View
      return;
    }
    navigateTo(RoutePaths.experimentsDetailView4Route, arguments: arguments);
  }

  // Dialog anzeigen und zur BLE-Scan-Seite weiterleiten
  void showDeviceConnectionDialog(BuildContext context, {MeasurementGraphArguments? arguments, String? routePath}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Erstmal das Gerät verbinden"),
          content: Text("Bitte verbinde zuerst ein Gerät, bevor du das Experiment startest."),
          actions: [
            TextButton(
              onPressed: () {
                // Dialog schließen und zur Experiment-Seite navigieren
                Navigator.of(dialogContext).pop();
                // Wenn Route und Argumente übergeben wurden, navigiere zum Experiment
                if (routePath != null && arguments != null) {
                  navigateTo(routePath, arguments: arguments);
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Schwarze Farbe für 'Abbrechen'
              ),
              child: Text("Abbrechen"),
            ),
            TextButton(
              onPressed: () {
                // Dialog schließen und zur BLE-Scan-Seite navigieren
                Navigator.of(dialogContext).pop();
                navigateTo(RoutePaths.newScanDeviceViewRoute);
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Dunkelblau für Verbinden-Button
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Zum Verbinden",
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to filter experiments based on search input
  void filterExperiments(String query) {
    if (query.isEmpty) {
      // If search is empty, display all experiments
      filteredExperiments = experimentData;
    } else {
      // Filter the experiments by title
      filteredExperiments = experimentData.where((experiment) {
        final title = experiment["title"]?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase());
      }).toList();
    }
    // Notify the UI to rebuild with the filtered experiments
    notifyListeners();
  }
}
