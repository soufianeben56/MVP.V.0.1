import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/service/routing/arguments/measurement_graph_arguments.dart';
import 'package:infinity_circuit/presentation/views/howtouse/howtouse_view.dart';
import 'package:infinity_circuit/presentation/widgets/term_link_widget.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/l10n.dart';
import 'experiments_detail_viewmodel.dart';

class ExperimentsDetailView4 extends StatelessWidget {
  final MeasurementGraphArguments arguments;

  const ExperimentsDetailView4({super.key, required this.arguments});

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
              baseChild: _getBody(context, model, arguments),
            ),
          ),
        );
      },
      onViewModelReady: (viewModel) => viewModel.onInit(),
    );
  }

  Widget _getBody(BuildContext context, ExperimentsDetailViewModel model,
      MeasurementGraphArguments arguments) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.relativeHeight(0.99)),
            homeContainers(
              title: stringExpTitle4,
              description: stringExpDescription3,
              assetGenImage: Assets.icons.imgCircuit4,
              imgHeight: 22.41,
              imgWidth: 64.48,
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
          Center(
            child: assetGenImage!
                .image(
                    height: SizeConfig.relativeHeight(imgHeight ?? 0),
                    width: SizeConfig.relativeWidth(imgWidth ?? 0))
                .wrapPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.relativeWidth(2.67),
                        vertical: SizeConfig.relativeHeight(0.99))),
          ),
          //
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.80),
                vertical: SizeConfig.relativeHeight(0.68)),
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: CommonTextWidget(
              text: stringExpTitle4,
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
                descriptionText(strZielDesc3),

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
                descriptionText(strFragenZurUntersuchung4),

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
            Text("2 x ", style: textStyle),
            TermLinkWidget(
              term: "NPN-Transistoren",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("2 x ", style: textStyle),
            TermLinkWidget(
              term: "LEDs",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Text("2 x Widerstände für die Basis = 10 kΩ", style: textStyle),
        SizedBox(height: 4),
        Text("2 x Widerstände für die LEDs = 330 Ω", style: textStyle),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("2 x ", style: textStyle),
            TermLinkWidget(
              term: "Kondensatoren",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(" = 10 µF", style: textStyle),
          ],
        ),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("1 x ", style: textStyle),
            TermLinkWidget(
              term: "Breadboard",
              sectionId: HowToUseSections.breadboards,
              style: textStyle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Text("Verbindungskabel", style: textStyle),
        SizedBox(height: 4),
        Text("3.3V SpannungQuelle", style: textStyle),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Messverbindung mit ", style: textStyle),
            TermLinkWidget(
              term: "CH0/CH1",
              sectionId: HowToUseSections.messboard,
              style: textStyle,
            ),
            Text(" falls benötigt", style: textStyle),
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
        Text("1. Schaltung betreiben:", style: textStyle),
        SizedBox(height: 4),
        Text("Verbinde die Schaltung mit der 3.3V SpannungQuelle.", style: textStyle),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Beobachte, wie die ", style: textStyle),
            TermLinkWidget(
              term: "LEDs",
              sectionId: HowToUseSections.otherComponents,
              style: textStyle,
            ),
            Text(" abwechselnd blinken. Die Blinkgeschwindigkeit wird durch die Werte von R, C, und T bestimmt.", style: textStyle),
          ],
        ),
        SizedBox(height: 8),
        Text("2. Analyse:", style: textStyle),
        SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Variiere die Werte von R, C, und T um zu sehen, wie sich die Frequenz des Blinksignals ändert. Verwende die Infinity Circuit App, um die Frequenz des erzeugten Rechtecksignals zu messen und zu analysieren.", style: textStyle),
          ],
        ),
      ],
    );
  }
}
