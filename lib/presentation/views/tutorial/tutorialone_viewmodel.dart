import '../../../service/base_model/base_model.dart';
import '../../../service/routing/navigation_service.dart';
import '../../../service/routing/route_paths.dart';

class TutorialOneViewmodel extends LocalBaseModel {
  @override
  void onTapTutorial() {
    // Use your navigation service to navigate to the RegisterView
    NavigationService().next(RoutePaths.tutoriallView);
  }
}
