import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';
import 'package:infinity_circuit/presentation/views/howtouse/howtouse_view.dart';
import 'package:infinity_circuit/presentation/widgets/term_link_widget.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/l10n.dart';
import 'experiments_detail_viewmodel.dart';

class ExperimentsDetailView2 extends StatelessWidget {
  final MeasurementGraphArguments arguments;
  const ExperimentsDetailView2({super.key, required this.arguments});

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
              title: stringExpTitle2,
              description: stringExpDescription2,
              assetGenImage: Assets.icons.imgCircuit2New,
              imgHeight: 20.69,
              imgWidth: 83.02,
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
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            child: const CommonTextWidget(
              text: stringExpTitle2,
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
                descriptionText(strZielDesc2),

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
                descriptionText(strSicherheitshinweise2),

                dividerWithSpace(),

                //

                headerText(strFragenZurUntersuchung),

                SizedBox(height: SizeConfig.relativeHeight(0.99)),
                descriptionText(strFragenZurUntersuchung2),

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
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Spannungsquelle: DAC (über ", style: textStyle),
            TermLinkWidget(
              term: "Messboard-Reihe 35",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(" und NICHT von 55)", style: textStyle),
          ],
        ),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TermLinkWidget(
              term: "Diode",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(" + ", style: textStyle),
            TermLinkWidget(
              term: "LED",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(" (rote LED mit 2V, 20mA)", style: textStyle),
          ],
        ),
        SizedBox(height: 4),
        Text("R1: Vorwiderstand (zu berechnen)", style: textStyle),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TermLinkWidget(
              term: "Shunt-Widerstand",
              sectionId: HowToUseSections.shuntResistor,
              style: textStyle,
            ),
            Text(": 1Ω (für Strommessung)", style: textStyle),
          ],
        ),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("4 Messleitungen: ", style: textStyle),
            TermLinkWidget(
              term: "CH0-CH3",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(" (Messboard-Reihe 1, 5, 10, 15)", style: textStyle),
          ],
        ),
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
        Text("1. Bauen Sie die Schaltung nach dem Schaltplan auf dem Breadboard auf.", style: textStyle),
        SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("2. Füge den ", style: textStyle),
            TermLinkWidget(
              term: "Shunt-Widerstand",
              sectionId: HowToUseSections.shuntResistor,
              style: textStyle,
            ),
            Text(" in Reihe ein - zur Strommessung", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Text("3. Verbinde den Shunt mit den Messpunkten, um den Strom durch die Diode zu ermitteln", style: textStyle),
        SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("o ", style: textStyle),
            TermLinkWidget(
              term: "CH2 (Messboard-Reihe 10)",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(" = Minus-Seite", style: textStyle),
          ],
        ),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("o ", style: textStyle),
            TermLinkWidget(
              term: "CH3 (Messboard-Reihe 15)",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(" = Plus-Seite", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Text("4. Miss die Spannung über der Diode ", style: textStyle),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("o ", style: textStyle),
            TermLinkWidget(
              term: "CH0 (Messboard-Reihe 1)",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text("= Anode", style: textStyle),
          ],
        ),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("o ", style: textStyle),
            TermLinkWidget(
              term: "CH1 (Messboard-Reihe 5)",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text("= Kathode", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Text("5. Verwenden Sie die Infinity Circuit App, um die Spannungs-Strom-Kennlinie der Diode zu analysieren und zu visualisieren", style: textStyle),
      ],
    );
  }
}
