import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/presentation/views/tutorial/tutorialone_viewmodel.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/l10n.dart';

class TutorialoneView extends StatelessWidget {
  const TutorialoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TutorialOneViewmodel>.reactive(
      viewModelBuilder: () => TutorialOneViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: S.current.anleitung,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            top: true,
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

  Widget _getBody(BuildContext context, TutorialOneViewmodel model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.relativeHeight(0.99)),
            homeContainers(
              title: stringExpTitle1,
              description: stringExpDescription1New,
              assetGenImage: Assets.icons.imgCircuit1,
              imgHeight: 15.89,
              imgWidth: 90.40,
            ),
            /* SizedBox(height: SizeConfig.relativeHeight(6.28)),
            CommonAppButton(onTap: () {}, title: "Messungen starten")
                .wrapPadding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.80),
              ),
            ),*/
            SizedBox(height: SizeConfig.relativeHeight(2)),
          ],
        ),
      ),
    );
  }

  Widget homeContainers(
      {String title = "",
      String description = "",
      AssetGenImage? assetGenImage,
      double? imgWidth,
      double? imgHeight,
      bool isDescription = true}) {
    return Container(
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.black.withOpacity(0.5), width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assetGenImage!
              .image(
                  height: SizeConfig.relativeHeight(imgHeight ?? 0),
                  width: SizeConfig.relativeWidth(imgWidth ?? 0))
              .wrapPadding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.relativeWidth(2.67),
                      vertical: SizeConfig.relativeHeight(0.99))),
          //
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.80),
                vertical: SizeConfig.relativeHeight(0.68)),
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: CommonTextWidget(
              text: stringTutorialTitle1,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: FontFamily.poppins,
            ),
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.23)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.80),
                vertical: SizeConfig.relativeHeight(1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                headerText(strEinfuhrung),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strEinfuhrung1),

                dividerWithSpace(),
                //
                headerText(strAnforderungsmetrik),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strAnforderungsmetrik1),

                dividerWithSpace(),

                //
                headerText(strWiemanExperimentedurchfuhrt),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strWiemanExperimentedurchfuhrt1),

                // dividerWithSpace(),

                //
                /* headerText(strSicherheitshinweise),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strSicherheitshinweise1),

                dividerWithSpace(),*/

                //

                /* headerText(strFragenZurUntersuchung),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strFragenZurUntersuchung1),*/

                // dividerWithSpace(),
              ],
            ),
          ),
        ],
      ),
    ).wrapPadding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(4.80)));
  }

  Widget headerText(String text) {
    return CommonTextWidget(
      text: text,
      fontSize: SizeConfig.setSp(14),
      color: AppColors.color212121,
      fontWeight: FontWeight.w600,
    );
  }

  Widget descriptionText(String text) {
    return CommonTextWidget(
      text: text,
      fontSize: SizeConfig.setSp(12),
      color: AppColors.color212121.withOpacity(0.6),
      fontWeight: FontWeight.w400,
    );
  }

  Widget dividerWithSpace() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.relativeHeight(1.97)),
        Divider(height: 0.5),
        SizedBox(height: SizeConfig.relativeHeight(1.97)),
      ],
    );
  }
}
