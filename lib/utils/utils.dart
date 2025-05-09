import 'package:infinity_circuit/exports.dart';

class Utils {
  static String getInitialPath() {
    // return RoutePaths.loginViewRoute;
    // bool? isFirstTime = UserPreference.haveKey(PrefKeys.isFirstTime);
    bool? isLogin = UserPreference.getBool(PrefKeys.isLogin);
    // isFirstTime ??= false;
    isLogin ??= false;
    if (isLogin) {
      return RoutePaths.homeViewRoute;
    } else {
      return RoutePaths.loginViewRoute;
    }
  }

  }

