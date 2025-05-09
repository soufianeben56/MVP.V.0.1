import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/presentation/views/secondtutorial/secondtutorial_viewmodel.dart';

import '../../../generated/assets.gen.dart';

class SecondTutorialView extends StatelessWidget {
  const SecondTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SecondTutorialViewModel>.reactive(
      viewModelBuilder: () => SecondTutorialViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: "Anleitung",
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

  Widget _getBody(BuildContext context, SecondTutorialViewModel model) {
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
                model.filterSolutions(value); // Filter the list on text change
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
              itemCount: model.filteredSolutionList.length,
              itemBuilder: (context, index) {
                final solution = model.filteredSolutionList[index];

                return homeContainers(
                  onTap: () {
                    // Navigate to different screens based on the item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => solution.navigateTo(),
                      ),
                    );
                  },
                  title: solution.title,
                  subtitle: solution.subtitle,
                  SvgGenImage: solution.svgGenImage,
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

  Widget homeContainers({
    String title = "",
    String subtitle = '',
    AssetGenImage? assetGenImage,
    required SvgGenImage SvgGenImage,
    Function()? onTap,
  }) {
    return Container(
      width:
          double.infinity, // Ensures the container takes full available width
      // height: SizeConfig.relativeHeight(20.0),

      padding: EdgeInsets.only(
        left: SizeConfig.relativeWidth(3.00),
        top: SizeConfig.relativeHeight(1.48),
        bottom: SizeConfig.relativeHeight(1.60),
        right: SizeConfig.relativeWidth(4.27),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor, width: 0.6),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgGenImage.svg(
                width: SizeConfig.relativeWidth(10.93),
                height: SizeConfig.relativeHeight(5.05),
              ).wrapPadding(padding: const EdgeInsets.only(right: 8.0)),

              // Wrap text in Expanded
              Expanded(
                child: CommonTextWidget(
                  text: title,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: FontFamily.poppins,
                  overflow: TextOverflow
                      .ellipsis, // Prevents overflow by truncating text
                ),
              ),

              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Assets.svg.icNextArrow.svg(),
                ),
              ),
            ],
          ),
          CommonTextWidget(
            text: subtitle,
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: FontFamily.poppins,
            color: Colors.grey,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    )
        .wrapPadding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(3.87)),
        )
        .addGestureTap(onTap: onTap!);
  }
}
