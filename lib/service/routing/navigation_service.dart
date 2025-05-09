import 'package:infinity_circuit/exports.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void back([Object? result]) {
    return navigationKey.currentState?.pop(result);
  }

  void popUntil(String routeName) {
    return navigationKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  Future<dynamic>? next(String routeName, {dynamic arguments}) {
    return navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? backAndNext(String routeName, {dynamic arguments}) {
    return navigationKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? backAllAndNext(String routeName, {dynamic arguments}) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
