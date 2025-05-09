import 'package:infinity_circuit/exports.dart';

class MyDeviceViewModel extends LocalBaseModel {
  // Add any properties or methods that you need for the view model here

  @override
  void onInit() {
    super.onInit();
  }

  //
  void onTapScan() {
    navigateTo(RoutePaths.scanDeviceViewRoute);
  }
}
