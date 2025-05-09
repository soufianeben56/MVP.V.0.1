import '../../../exports.dart';
import '../../../local/pref_keys.dart';
import '../../../local/user_preference.dart';
import 'package:infinity_circuit/service/base_model/base_model.dart';
import 'package:infinity_circuit/service/routing/route_paths.dart';

import '../connect_blue/scanning_screen.dart';

class HomeViewModel extends LocalBaseModel {
  @override
  void onInit() {
    // Fetch the registered name from preferences
    registeredName = UserPreference.getString(PrefKeys.name);

    // Notify the UI to update
    notifyListeners();

    super.onInit();
  }

  void onTapExperiments() {
    navigateTo(RoutePaths.homeExperimentsViewRoute);
  }

  void onTapSolution() {
    navigateTo(RoutePaths.solutionViewRoute);
  }

  void onTapTutorial() {
    navigateTo(RoutePaths.secondtutoriallView);
  }

  void onTapLogout() {
    navigateTo(RoutePaths.logoutView);
  }

  void onTapNotConnect() {
    navigateTo(RoutePaths.scanDeviceViewRoute);
  }

  void onTapHowToUse() {
    navigateTo(RoutePaths.howtouseView);
  }

  void navigateToConnectingBLUE(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScanningScreen()),
    );
  }

  String? registeredName;
}
