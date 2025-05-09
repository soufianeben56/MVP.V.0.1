import 'package:infinity_circuit/exports.dart';

class DiscoverProfilController extends LocalBaseModel {
  @override
  void onInit() {
    profileName = UserPreference.getString(PrefKeys.name);
    notifyListeners();
    super.onInit();
  }

  void onTapActivities() {

  }

  void onTapSettings() {

  }

  void onTapHelp() {

  }

  void onTapDisconnect() {
    navigateTo(RoutePaths.logoutView);
  }

  String? profileName;
}
