import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/service/base_model/base_model.dart';
import 'package:infinity_circuit/service/routing/route_paths.dart';


class SafetyViewmodel extends LocalBaseModel {
  @override
  void onInit() {
    super.onInit();
  }
  void onTapMyDevice() {
    navigateTo(RoutePaths.myDeviceViewRoute);
  }
}