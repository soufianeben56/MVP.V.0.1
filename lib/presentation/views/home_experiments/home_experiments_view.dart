import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/generated/l10n.dart';
import 'package:infinity_circuit/presentation/views/logout/logout_view.dart';
import '../connect_blue/blue_manager.dart';
import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';
import '../measurement_graph/CustomGraphViewModel.dart';
import '../../../constants/app_constants.dart';
import 'package:infinity_circuit/service/routing/route_paths.dart';

import 'home_experiments_viewmodel.dart';

class HomeExperimentsView extends StatelessWidget {
  const HomeExperimentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeExperimentsViewModel>.reactive(
      viewModelBuilder: () => HomeExperimentsViewModel(),
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

  Widget _getBody(BuildContext context, HomeExperimentsViewModel model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, 'homeViewRoute');
                      },
                      child: Assets.svg.icHomeback.svg(
                        width: SizeConfig.relativeWidth(11.73),
                        height: SizeConfig.relativeHeight(5.42),
                      ),
                    ),
                    SizedBox(width: SizeConfig.relativeWidth(2.40)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          text: S.current.hiThere,
                          fontSize: SizeConfig.setSp(12),
                          color: AppColors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                        CommonTextWidget(
                          text: model.registeredName ?? "",
                          fontSize: SizeConfig.setSp(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(RoutePaths.newScanDeviceViewRoute);
                      },
                      child: Assets.svg.icImage111.svg(
                        width: SizeConfig.relativeWidth(10.40),
                        height: SizeConfig.relativeHeight(4.68),
                      ),
                    ),
                    SizedBox(width: SizeConfig.relativeWidth(2.13)),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogoutView();
                          },
                        );
                      },
                      child: Assets.svg.icLogout.svg(
                        width: SizeConfig.relativeWidth(10.40),
                        height: SizeConfig.relativeHeight(4.68),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CommonTextWidget(
                  text: S().welcome,
                  fontWeight: FontWeight.w700,
                  fontSize: 27.68,
                  color: AppColors.white,
                ),
                CommonTextWidget(
                  text: S().toInfinityCircuit,
                  fontWeight: FontWeight.w500,
                  fontSize: 23.07,
                  color: AppColors.white,
                ),
                SizedBox(height: SizeConfig.relativeHeight(1.60)),
              ],
            ).wrapPadding(padding: EdgeInsets.symmetric(horizontal: 18)),
          ),
          SizedBox(height: SizeConfig.relativeHeight(3.94)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: S.current.experiments,
                    fontSize: SizeConfig.setSp(14),
                    color: AppColors.color212121,
                    fontWeight: FontWeight.w500,
                  ).wrapPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.relativeWidth(5.87))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonSearchBar(
                      controller: model.searchController, // Use the controller from the ViewModel
                      onChanged: (value) {
                        model.filterExperiments(
                            value); // Filter based on search query
                      },
                      onEditingComplete: () {},
                      onSubmitted: (value) {},
                      AssetsSvgGen: Assets.svg.icSearch,
                    ),
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(0.99)),
                  // Dynamically show filtered experiment data
                  ...model.filteredExperiments
                      .map((experiment) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.relativeHeight(1.48)),
                            child: homeContainers(
                              title: experiment["title"],
                              description: experiment["description"] ?? '',
                              assetGenImage: experiment["assetGenImage"],
                              imgHeight: experiment["imgHeight"],
                              imgWidth: experiment["imgWidth"],
                              isDescription: experiment["description"] != null,
                              onTap: () {
                                // Überprüfe, ob ein Gerät verbunden ist
                                if (!BLEManager().isDeviceConnected()) {
                                  // Extrahiere die Argumente für dieses Experiment
                                  String targetRoute = '';
                                  MeasurementGraphArguments args;
                                  
                                  // Verwende das Experiment-Map, um Informationen zu extrahieren
                                  args = MeasurementGraphArguments(
                                    assetGenImage: experiment["assetGenImage"],
                                    imgHeight: experiment["imgHeight"],
                                    imgWidth: experiment["imgWidth"],
                                    experiment: _getExperimentType(experiment["title"]),
                                  );
                                  
                                  // Bestimme die Zielroute basierend auf dem Titel
                                  if (experiment["title"] == stringExpTitle1) {
                                    targetRoute = RoutePaths.experimentsDetailView1Route;
                                  } else if (experiment["title"] == stringExpTitle2) {
                                    targetRoute = RoutePaths.experimentsDetailView2Route;
                                  } else if (experiment["title"] == stringExpTitle3) {
                                    targetRoute = RoutePaths.experimentsDetailView3Route;
                                  } else if (experiment["title"] == stringExpTitle4) {
                                    targetRoute = RoutePaths.experimentsDetailView4Route;
                                  }
                                  
                                  // Zeige den Verbindungsdialog, wenn kein Gerät verbunden ist
                                  model.showDeviceConnectionDialog(
                                    context,
                                    arguments: args,
                                    routePath: targetRoute,
                                  );
                                  return;
                                }
                                // Führe die normale Experiment-Navigation aus
                                experiment["onTap"](model);
                              },
                            ),
                          ),
                          ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget homeContainers(
      {String title = "",
      String description = "",
      AssetGenImage? assetGenImage,
      double? imgWidth,
      double? imgHeight,
      required Function()? onTap,
      bool isDescription = true}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.white.withOpacity(0.5), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: CommonTextWidget(
                  text: title,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  fontFamily: FontFamily.poppins,
                ),
              ),
              Spacer(),
              Assets.svg.icNextArrow.svg()
            ],
          ),
          SizedBox(height: SizeConfig.relativeHeight(1.23)),
          assetGenImage!.image(
              height: SizeConfig.relativeHeight(imgHeight ?? 0),
              width: SizeConfig.relativeWidth(imgWidth ?? 0)),
          SizedBox(height: SizeConfig.relativeHeight(1.23)),
          isDescription
              ? CommonTextWidget(
                  text: description,
                  fontSize: SizeConfig.setSp(14),
                  color: AppColors.color282828.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                )
              : SizedBox.shrink()
        ],
      ),
    )
        .wrapPadding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(5)))
        .addGestureTap(onTap: onTap!);
  }

  // Hilfsmethode, um den Experiment-Typ aus dem Titel zu bestimmen
  Experiment _getExperimentType(String title) {
    if (title == stringExpTitle1) return Experiment.experiment1;
    if (title == stringExpTitle2) return Experiment.experiment2;
    if (title == stringExpTitle3) return Experiment.experiment3;
    if (title == stringExpTitle4) return Experiment.experiment4;
    return Experiment.experiment1; // Standardwert
  }
}
