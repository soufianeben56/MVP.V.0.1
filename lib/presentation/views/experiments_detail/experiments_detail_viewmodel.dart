import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';

import 'package:infinity_circuit/service/base_model/base_model.dart';
import 'package:infinity_circuit/service/routing/route_paths.dart';

class ExperimentsDetailViewModel extends LocalBaseModel {
  @override
  void onInit() {
    super.onInit();
  }

  void onTapButton(MeasurementGraphArguments arguments) {
    navigateTo(RoutePaths.measurementGraphViewRoute, arguments: arguments);
  }
}
