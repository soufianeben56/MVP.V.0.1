import '../../../exports.dart';
import '../../../generated/assets.gen.dart';

enum SolutionType { solution1, solution2, solution3, solution4 }

class SolutionViewModel extends LocalBaseModel {
  TextEditingController searchController = TextEditingController();
  SolutionType? selectedSolution;

  List<SolutionModel> filteredSolutions = [];

  @override
  void onInit() {
    super.onInit();
    filteredSolutions = solutionList;
  }

  void onTapListTile(SolutionType solution) {
    selectedSolution = solution;
    navigateTo(RoutePaths.solutionDetailViewRoute, arguments: solution);
  }

  List<SolutionModel> solutionList = [
    SolutionModel(
        "RLC-Schaltung", Assets.icons.icSolution1, SolutionType.solution1),
    SolutionModel("Zener-Dioden-Experiment mit LED ", Assets.icons.icSolution2,
        SolutionType.solution2),
    SolutionModel("Brückenschaltungs- Experiment ", Assets.icons.icSolution3,
        SolutionType.solution3),
    SolutionModel("Astabilen Multivibrator- Schaltung",
        Assets.icons.icSolution4, SolutionType.solution4),
  ];

  // Method to filter the list based on the search query
  void filterSolutions(String query) {
    if (query.isEmpty) {
      // If the search bar is empty, show all solutions
      filteredSolutions = solutionList;
    } else {
      filteredSolutions = solutionList
          .where((solution) =>
              solution.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }
}

class SolutionModel {
  final String title;
  final AssetGenImage assetGenImage;
  final SolutionType solutionType;

  SolutionModel(this.title, this.assetGenImage, this.solutionType);
}
