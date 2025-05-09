import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import '../../../generated/assets.gen.dart';
import 'solution_viewmodel.dart';

class SolutionView extends StatelessWidget {
  const SolutionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SolutionViewModel>.reactive(
      viewModelBuilder: () => SolutionViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: "Lösung",
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            top: false,
            child: CentralLoader(
              centralViewState: model.viewState,
              baseChild: _getBody(context, model),
            ),
          ),
        );
      },
      onViewModelReady: (viewModel) => viewModel.onInit(),
    );
  }

  Widget _getBody(BuildContext context, SolutionViewModel model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.relativeHeight(3.57)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CommonSearchBar(
              onChanged: (value) {
                model.filterSolutions(value);
              },
              controller: model.searchController,
              onEditingComplete: () {},
              onSubmitted: (value) {},
              AssetsSvgGen: Assets.svg.icSearch,
            ),
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.72)),
          Expanded(
            child: ListView.separated(
              itemCount: model.filteredSolutions.length,
              itemBuilder: (context, index) {
                final solution = model.filteredSolutions[index];
                return homeContainers(
                  onTap: () {
                    model.onTapListTile(solution.solutionType);
                  },
                  title: solution.title,
                  assetGenImage: solution.assetGenImage,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: SizeConfig.relativeHeight(1.48));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget homeContainers(
      {String title = "", AssetGenImage? assetGenImage, Function()? onTap}) {
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.relativeWidth(4.00),
          top: SizeConfig.relativeHeight(1.48),
          bottom: SizeConfig.relativeHeight(1.60),
          right: SizeConfig.relativeWidth(4.27)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.black.withOpacity(0.3), width: 0.6)),
      child: Row(
        children: [
          assetGenImage!.image(
            width: SizeConfig.relativeWidth(10.93),
            height: SizeConfig.relativeHeight(5.05),
          ),
          SizedBox(width: SizeConfig.relativeWidth(3.47)),
          Expanded(
            child: CommonTextWidget(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              fontFamily: FontFamily.poppins,
            ),
          ),
          // Spacer(),
          Container(
              alignment: Alignment.topRight,
              child: Assets.svg.icNextArrow.svg())
        ],
      ),
    )
        .wrapPadding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(5.87)))
        .addGestureTap(onTap: onTap!);
  }
}
