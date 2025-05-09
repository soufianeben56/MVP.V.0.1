import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';
import 'package:infinity_circuit/presentation/views/howtouse/howtouse_view.dart';
import 'package:infinity_circuit/presentation/widgets/term_link_widget.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/l10n.dart';
import 'experiments_detail_viewmodel.dart';

class ExperimentsDetailView1 extends StatelessWidget {
  final MeasurementGraphArguments arguments;
  const ExperimentsDetailView1({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExperimentsDetailViewModel>.reactive(
      viewModelBuilder: () => ExperimentsDetailViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: S.current.experiments,
            backgroundColor: Colors.transparent, // Transparent AppBar
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

  Widget _getBody(BuildContext context, ExperimentsDetailViewModel model) {
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
              assetGenImage: Assets.icons.imgCircuit1New,
              imgHeight: 15.89,
              imgWidth: 90.40,
            ),
            SizedBox(height: SizeConfig.relativeHeight(4.28)),
            CommonAppButton(
              onTap: () {
                model.onTapButton(arguments);
              },
              title: "Messung starten",
              width: null,
            ).wrapPadding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.80),
              ),
            ),
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
              text: stringExpTitle1,
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
                headerText(strZiel),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strZielDesc1),

                dividerWithSpace(),
                //
                headerText(strBenotigteMaterialien),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                _buildMaterialsWithLinks(),

                dividerWithSpace(),

                //
                headerText(strAnleitung),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                _buildInstructionsWithLinks(),

                dividerWithSpace(),

                //
                headerText(strSicherheitshinweise),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strSicherheitshinweise1),

                dividerWithSpace(),

                //

                headerText(strFragenZurUntersuchung),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                // descriptionText(strFragenZurUntersuchung1),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Berechnen Sie die Resonanzfrequenz der in Reihe geschalteten RLC-Schaltung sowohl rechnerisch als auch experimentell.\n\n"
                            "Wie verhält sich die gemessene Resonanzfrequenz im Vergleich zur berechneten?\n\n",
                        style: TextStyle(
                            fontSize: SizeConfig.setSp(12),
                            color: AppColors.color212121.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                      TextSpan(
                        text:
                            "Beobachten Sie die Phasenverschiebung zwischen Strom und Spannung im  Kondensator  als auch im Widerstand!\n\n",
                        style: TextStyle(
                            fontSize: SizeConfig.setSp(12),
                            color: AppColors.color212121.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ).wrapPadding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(4.80)));
  }
  
  /// Builds the materials section with clickable terms that link to the How To Use section
  Widget _buildMaterialsWithLinks() {
    // Style for normal text
    final textStyle = TextStyle(
      fontSize: SizeConfig.setSp(12),
      color: AppColors.color212121.withOpacity(0.6),
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AC-Signal: + 1.2V BIS -1.2V", style: textStyle),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TermLinkWidget(
              term: "Widerstand",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(": 68 Ω", style: textStyle),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TermLinkWidget(
              term: "Spule",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(" (L): 4.7 mH", style: textStyle),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TermLinkWidget(
              term: "Kondensator",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(" (C): 220 µF", style: textStyle),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TermLinkWidget(
              term: "Shunt-Widerstand",
              sectionId: HowToUseSections.shuntResistor,
              style: textStyle,
            ),
            Text(": 5 Ω (zur Strommessung).", style: textStyle),
          ],
        ),
        Text("Verbindungskabel.", style: textStyle),
      ],
    );
  }
  
  /// Builds the instructions section with clickable terms that link to the How To Use section
  Widget _buildInstructionsWithLinks() {
    // Style for normal text
    final textStyle = TextStyle(
      fontSize: SizeConfig.setSp(12),
      color: AppColors.color212121.withOpacity(0.6),
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Verbinde die ", style: textStyle),
            TermLinkWidget(
              term: "Messboard-Reihe 50",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(" mit deiner Schaltung - das ist die Sinusversorgung.", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Text("1. Setze den 100Ω Widerstand in Reihe mit dem Eingangssignal", style: textStyle),
        SizedBox(height: 8),
        Text("2. Schließe Spule und Kondensator in Reihe zur Sinusquelle an.", style: textStyle),
        SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("3. Füge den 5Ω ", style: textStyle),
            TermLinkWidget(
              term: "Shunt-Widerstand",
              sectionId: HowToUseSections.shuntResistor,
              style: textStyle,
            ),
            Text(" zur Strommessung in den Stromkreis ein.", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("4. Stecke die beiden Kabel aus der Schaltung in ", style: textStyle),
            TermLinkWidget(
              term: "Messboard-Reihe 25 und 30",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(", um die Spannung zwischen diesen zwei Punkten zu messen.", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("5. Der Output der Differenzspannung liegt auf ", style: textStyle),
            TermLinkWidget(
              term: "Reihe 20 (Messboard)",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(". Verbinden Sie diesen Punkt mit ", style: textStyle),
            TermLinkWidget(
              term: "CH0 (Messboard-Reihe 1)",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(", damit das Messergebnis gezeigt wird.", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Text("7. Starte die App, um Spannung und Strom gleichzeitig als Kurve zu sehen und die Phasenverschiebung zu analysieren", style: textStyle),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Hinweis zur Phasenverschiebung:",
                      style: TextStyle(
                        fontSize: SizeConfig.setSp(13),
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                "Bei der Messung der Phasenverschiebung zwischen Strom und Spannung ist es wichtig, auf die korrekte Verdrahtung zu achten: Wenn die Phasenmessung um +/- 180° von Ihrem erwarteten Wert abweicht, versuchen Sie die Anschlüsse des entsprechenden Messkreises zu vertauschen.",
                style: TextStyle(
                  fontSize: SizeConfig.setSp(12),
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerText(String text) {
    return CommonTextWidget(
      text: text,
      fontSize: SizeConfig.setSp(16),
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
