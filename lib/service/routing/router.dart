import 'package:infinity_circuit/presentation/views/devicenotconnect/devicenotconnect_view.dart';
import 'package:infinity_circuit/presentation/views/experiments_detail/experiments_detail_view1.dart';
import 'package:infinity_circuit/presentation/views/experiments_detail/experiments_detail_view2.dart';
import 'package:infinity_circuit/presentation/views/experiments_detail/experiments_detail_view3.dart';
import 'package:infinity_circuit/presentation/views/experiments_detail/experiments_detail_view4.dart';
import 'package:infinity_circuit/presentation/views/measurement_graph/measurement_graph_view.dart';
import 'package:infinity_circuit/presentation/views/mydevice/mydevice_view.dart';
import 'package:infinity_circuit/presentation/views/register/register_view.dart';
import 'package:infinity_circuit/presentation/views/scandevice/scandevice_view.dart';
import 'package:infinity_circuit/presentation/views/solution/solution_view.dart';
import 'package:infinity_circuit/presentation/views/solution_detail/solution_detail_view.dart';
import 'package:infinity_circuit/router_exports.dart';
import 'package:infinity_circuit/service/routing/arguments/device_list_arguments.dart';

import '../../exports.dart';
import '../../presentation/views/connect_blue/scanning_screen.dart';
import '../../presentation/views/deviceList/devicelist_view.dart';
import '../../presentation/views/home_experiments/home_experiments_view.dart';
import '../../presentation/views/howtouse/howtouse_view.dart';
import '../../presentation/views/login/login_view.dart';
import '../../presentation/views/logout/logout_view.dart';
import '../../presentation/views/safety/safety_view.dart';
import '../../presentation/views/secondtutorial/secondtutorial_view.dart';
import '../../presentation/views/solution/solution_viewmodel.dart';
import '../../presentation/views/tutorial/tutorialone_view.dart';
import 'arguments/measurement_graph_arguments.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    //
    case RoutePaths.splashViewRoute:
      return _getPage(
        page: const SplashView(),
        settings: settings,
      );
    //
    case RoutePaths.homeViewRoute:
      return _getPage(
        page: const HomeView(),
        settings: settings,
      );
    //
    case RoutePaths.homeExperimentsViewRoute:
      // final arguments = settings.arguments as MeasurementGraphArguments;
      return _getPage(
        page: HomeExperimentsView(),
        settings: settings,
      );
    case RoutePaths.scanDeviceViewRoute:
      return _getPage(
        page: ScanDeviceView(),
        settings: settings,
      );
    //
    case RoutePaths.experimentsDetailView1Route:
      final arguments = settings.arguments as MeasurementGraphArguments;
      return _getPage(
        page: ExperimentsDetailView1(arguments: arguments),
        settings: settings,
      ); //
    case RoutePaths.experimentsDetailView2Route:
      final arguments = settings.arguments as MeasurementGraphArguments;

      return _getPage(
        page: ExperimentsDetailView2(arguments: arguments),
        settings: settings,
      ); //
    case RoutePaths.experimentsDetailView3Route:
      final arguments = settings.arguments as MeasurementGraphArguments;

      return _getPage(
        page: ExperimentsDetailView3(
          arguments: arguments,
        ),
        settings: settings,
      ); //
    case RoutePaths.experimentsDetailView4Route:
      final arguments = settings.arguments as MeasurementGraphArguments;

      return _getPage(
        page: ExperimentsDetailView4(
          arguments: arguments,
        ),
        settings: settings,
      );
    case RoutePaths.loginViewRoute:
      return _getPage(
        page: LoginView(),
        settings: settings,
      );
    case RoutePaths.registerViewRoute:
      return _getPage(
        page: RegisterView(),
        settings: settings,
      );
    case RoutePaths.safetyViewRoute:
      return _getPage(
        page: SafetyView(),
        settings: settings,
      );
    case RoutePaths.tutoriallView:
      return _getPage(
        page: TutorialoneView(),
        settings: settings,
      );

    case RoutePaths.secondtutoriallView:
      return _getPage(
        page: SecondTutorialView(),
        settings: settings,
      );
    //
    case RoutePaths.solutionViewRoute:
      return _getPage(
        page: const SolutionView(),
        settings: settings,
      );
    //
    case RoutePaths.solutionDetailViewRoute:
      final solutionType = settings.arguments as SolutionType;

      return _getPage(
        page: SolutionDetailView(selectedSolution: solutionType),
        settings: settings,
      );

    //
    case RoutePaths.measurementGraphViewRoute:
      final arguments = settings.arguments as MeasurementGraphArguments;

      return _getPage(
        page: MeasurementGraphView(arguments: arguments),
        settings: settings,
      );

    case RoutePaths.logoutView:
      return _getPage(
        settings: settings,
        page: LogoutView(),
      );
    case RoutePaths.myDeviceViewRoute:
      return _getPage(
        page: MyDeviceView(),
        settings: settings,
      );
    case RoutePaths.deviceListView:
      // Cast the arguments as a list of DeviceListArguments
      final arguments = settings.arguments as List<DeviceListArguments>;

      return _getPage(
        page:
            DeviceListView(devicesList: arguments), // Pass the list to the view
        settings: settings,
      );

    case RoutePaths.howtouseView:
      return _getPage(
        page: HowToUseView(),
        settings: settings,
      );

    case RoutePaths.deviceNotConnectView:
      return _getPage(
        settings: settings,
        page: DevicenotConnectView(),
      );

    case RoutePaths.newScanDeviceViewRoute:
      return _getPage(
        page: ScanningScreen(),
        settings: settings,
      );

    default:
      return _getPage(
        settings: settings,
        page: const Scaffold(
          body: Center(
            child: Text("Page Is Not Defined"),
          ),
        ),
      );
  }
}

PageTransition _getPage({
  required RouteSettings settings,
  Widget page = const SafeArea(
    top: true,
    child: Scaffold(
      body: Center(
        child: Text("Page Is Not Defined"),
      ),
    ),
  ),
  PageTransitionType? type,
}) {
  return PageTransition(
    child: page,
    settings: settings,
    type: type ?? PageTransitionType.rightToLeft,
    isIos: Platform.isIOS,
  );
}
