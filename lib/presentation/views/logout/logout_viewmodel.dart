import 'package:infinity_circuit/exports.dart';

class LogoutViewModel extends LocalBaseModel {
  Future<void> onTapLogout() async {
    await UserPreference.logout();
    redirectWithClearBackStack(RoutePaths.loginViewRoute);
  }

  onTapBack() {
    back();
  }
}
