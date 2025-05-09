import 'package:infinity_circuit/service/routing/route_paths.dart';

import '../../../local/pref_keys.dart';
import '../../../local/user_preference.dart';
import '../../../service/base_model/base_model.dart';

class SplashViewModel extends LocalBaseModel {
  @override
  void onInit() {
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () async {
        bool? isLogin = UserPreference.getBool(PrefKeys.isLogin);
        isLogin ??= false;
        if (isLogin) {
          redirectWithClearBackStack(RoutePaths.homeViewRoute);
        } else {
          redirectWithClearBackStack(RoutePaths.loginViewRoute);
        }
      },
    );
    super.onInit();
  }
}
