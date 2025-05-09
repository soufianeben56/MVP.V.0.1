import 'package:infinity_circuit/exports.dart';
import '../../../generated/assets.gen.dart';
import '../tutorial/tutorialone_view.dart';

class SecondTutorialViewModel extends LocalBaseModel {
  final TextEditingController searchController = TextEditingController();

  List<SecondtutorialModel> filteredSolutionList = [];

  @override
  void onInit() {
    super.onInit();
    // Show full list by default
    filteredSolutionList = solutionList;
  }

  void onTapListTile() {
    navigateTo(RoutePaths.tutoriallView);
  }

  // Filter method to update the list based on search query
  void filterSolutions(String query) {
    if (query.isEmpty) {
      filteredSolutionList = solutionList;
    } else {
      filteredSolutionList = solutionList
          .where((solution) =>
              solution.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

// Sample list of tutorial items with navigation
  List<SecondtutorialModel> solutionList = [
    SecondtutorialModel(
      "RLC-Schaltung ",
      Assets.svg.icGroup11,
      "Lorem ipsum dolor sit amet consectetur. Sapien risus tincidunt neque aliquam eleifend proin justo. Leo eleifend viverra at volutpat",
      () => TutorialoneView(), // Replace with your actual widget
    ),
  ];
}

// Model class to hold data and navigate
class SecondtutorialModel {
  final String title;
  final String subtitle;
  final SvgGenImage svgGenImage;
  final Widget Function() navigateTo;

  SecondtutorialModel(
      this.title, this.svgGenImage, this.subtitle, this.navigateTo);
}
