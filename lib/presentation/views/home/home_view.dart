import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/presentation/views/logout/logout_view.dart';

import '../discover_profil/discover_profil_screen.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
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

  Widget _getBody(BuildContext context, HomeViewModel model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.relativeHeight(8)),
                Row(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DiscoverProfilScreen(),
                            ),
                          );
                        },
                        child: ClipOval(
                          child: Image.asset(
                            Assets.icons.imgUserJpg.path,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: SizeConfig.relativeWidth(2.40)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          text: "Hallo,",
                          fontSize: SizeConfig.setSp(12),
                          color: AppColors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                        CommonTextWidget(
                          text: model.registeredName ?? "No name found",
                          fontSize: SizeConfig.setSp(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        log("onTapNotConnect");
                        //model.onTapNotConnect();
                         Navigator.of(context).pushNamed(RoutePaths.newScanDeviceViewRoute);
                      },
                      child: Assets.svg.icDisconnect.svg(
                        width: SizeConfig.relativeWidth(10.40),
                        height: SizeConfig.relativeHeight(4.68),
                      ),
                    ),
                    SizedBox(width: SizeConfig.relativeWidth(2.13)),
                    Assets.svg.icLogout
                        .svg(
                      width: SizeConfig.relativeWidth(10.40),
                      height: SizeConfig.relativeHeight(4.68),
                    )
                        .addGestureTap(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogoutView();
                          },
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                CommonTextWidget(
                  text: "Willkommen",
                  fontWeight: FontWeight.w700,
                  fontSize: 27.68,
                  color: AppColors.white,
                ),
                CommonTextWidget(
                  text: "Zum Infinity Circuit",
                  fontWeight: FontWeight.w500,
                  fontSize: 23.07,
                  color: AppColors.white,
                ),
                SizedBox(height: SizeConfig.relativeHeight(1.60)),
              ],
            ).wrapPadding(padding: EdgeInsets.symmetric(horizontal: 18)),
          ),
          SizedBox(height: SizeConfig.relativeHeight(6.16)),
          homeContainers(
            title: "Experiment",
            svgGenImage: Assets.svg.icExperiments,
            onTap: () {
              model.onTapExperiments();
            },
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.48)),
          //homeContainers(
            //onTap: () {
              //model.onTapTutorial();
            //},
            //title: "Anleitung",
           // svgGenImage: Assets.svg.icTutorial,
          //),
          //SizedBox(height: SizeConfig.relativeHeight(1.48)),
          homeContainers(
              onTap: () {
                model.onTapSolution();
              },
              title: "Lösung",
              svgGenImage: Assets.svg.icSolution),
          SizedBox(height: SizeConfig.relativeHeight(1.48)),
          homeContainers(
              onTap: () {
                model.onTapHowToUse();
                //model.navigateToConnectingBLUE(context);
              },
              title: "Bedienungshinweise",
              svgGenImage: Assets.svg.icSolution),
        ],
      ),
    );
  }

  Widget homeContainers(
      {String title = "", SvgGenImage? svgGenImage, Function()? onTap}) {
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.relativeWidth(3.20),
          top: SizeConfig.relativeHeight(1.35),
          bottom: SizeConfig.relativeHeight(1.35),
          right: SizeConfig.relativeWidth(3.73)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.white.withOpacity(0.6), width: 1)),
      child: Row(
        children: [
          svgGenImage!.svg(
            width: SizeConfig.relativeWidth(10.93),
            height: SizeConfig.relativeHeight(5.05),
          ),
          SizedBox(
            width: SizeConfig.relativeWidth(3.47),
          ),
          CommonTextWidget(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: FontFamily.poppins,
          ),
          Spacer(),
          Assets.svg.icNextArrow.svg()
        ],
      ),
    )
        .wrapPadding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(5.87)))
        .addGestureTap(onTap: onTap!);
  }
}
