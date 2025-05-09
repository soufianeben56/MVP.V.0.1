import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'discover_profil_controller.dart';

class DiscoverProfilScreen extends StatelessWidget {
  const DiscoverProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverProfilController>.reactive(
      viewModelBuilder: () => DiscoverProfilController(),
      builder: (context, model, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.colorF4F4F4,
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

  Widget _getBody(BuildContext context, DiscoverProfilController model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.relativeHeight(30.79),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.icons.imgHomeBg.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: SizeConfig.relativeHeight(8),
                left: SizeConfig.relativeWidth(4),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Assets.svg.icHomeback.svg(
                        width: SizeConfig.relativeWidth(11.73),
                        height: SizeConfig.relativeHeight(5.42),
                      ),
                    ),
                    SizedBox(width: SizeConfig.relativeWidth(2.40)),
                  ],
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.relativeHeight(8.0)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        Assets.icons.imgUserJpg.path,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: SizeConfig.relativeHeight(1.6)),
                    CommonTextWidget(
                      text: model.profileName ?? "No Name Found",
                      fontSize: SizeConfig.setSp(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.relativeHeight(4.0)),
          profileOptionsContainer(
            title: "My Activities",
            svgGenImage: Assets.svg.icConnect2,
            onTap: () {
              model.onTapActivities();
            },
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.48)),
          profileOptionsContainer(
            title: "Settings",
            svgGenImage: Assets.svg.icConnect2,
            onTap: () {
              model.onTapSettings();
            },
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.48)),
          profileOptionsContainer(
            title: "Help",
            svgGenImage: Assets.svg.icConnect,
            onTap: () {
              model.onTapHelp();
            },
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.48)),
          profileOptionsContainer(
            title: "Logout",
            svgGenImage: Assets.svg.icConnect2,
            onTap: () {
              model.onTapDisconnect();
            },
          ),
        ],
      ),
    );
  }

  Widget profileOptionsContainer({
    required String title,
    required SvgGenImage? svgGenImage,
    required Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.relativeWidth(3.20),
        top: SizeConfig.relativeHeight(1.35),
        bottom: SizeConfig.relativeHeight(1.35),
        right: SizeConfig.relativeWidth(2.5),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.white.withOpacity(0.6),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          svgGenImage!.svg(
            width: SizeConfig.relativeWidth(5.0),
            height: SizeConfig.relativeHeight(3.5),
            color: Colors.grey,
          ),
          SizedBox(width: SizeConfig.relativeWidth(3.47)),
          CommonTextWidget(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            fontFamily: FontFamily.poppins,
          ),
          Spacer(),
          Assets.svg.icNextArrow.svg(
            width: SizeConfig.relativeWidth(6.0),
            height: SizeConfig.relativeHeight(3.0),
          ),
        ],
      ),
    ).wrapPadding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(5.87)),
    ).addGestureTap(onTap: onTap!);
  }
}
