import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';

import '../../../generated/assets.gen.dart';

import '../solution/solution_viewmodel.dart';
import 'solution_detail_viewmodel.dart';

class SolutionDetailView extends StatelessWidget {
  final SolutionType selectedSolution;

  SolutionDetailView({required this.selectedSolution, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SolutionDetailViewModel>.reactive(
      viewModelBuilder: () => SolutionDetailViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: "Lösung",
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

  String getTitle(SolutionType solutionType) {
    switch (solutionType) {
      case SolutionType.solution1:
        return "RLC-Schaltung";
      case SolutionType.solution2:
        return "Dioden-Experiment mit LED";
      case SolutionType.solution3:
        return "Brückenschaltungs-Experiment";
      case SolutionType.solution4:
        return "Astabilen Multivibrator-Schaltung";
      default:
        return "Unbekannte Lösung";
    }
  }

  Widget _getBody(BuildContext context, SolutionDetailViewModel model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.relativeHeight(3)),
            homeContainers(
              title: stringExpTitle1,
              description: stringExpDescription1New,
              assetGenImage: Assets.icons.imgSolution1New,
              imgHeight: 20.00,
              imgWidth: 80.00,
              solutionType: selectedSolution,
            ),
            SizedBox(height: SizeConfig.relativeHeight(6.28)),
          ],
        ),
      ),
    );
  }

  Map<SolutionType, AssetGenImage> solutionImages = {
    SolutionType.solution1: Assets.icons.imgSolution1New,
    SolutionType.solution2: Assets.icons.imgSolution2New,
    SolutionType.solution3: Assets.icons.imgSolution3New,
    SolutionType.solution4: Assets.icons.imgSolution4New,
  };

  Map<SolutionType, Map<String, double>> solutionDimensions = {
    SolutionType.solution1: {
      'height': 20.0,
      'width': 80.0,
    },
    SolutionType.solution2: {
      'height': 20.0,
      'width': 80.0,
    },
    SolutionType.solution3: {
      'height': 20.0,
      'width': 80.0,
    },
    SolutionType.solution4: {
      'height': 20.0,
      'width': 80.0,
    },
  };

  Widget homeContainers(
      {String title = "",
      String description = "",
      AssetGenImage? assetGenImage,
      double? imgWidth,
      double? imgHeight,
      SolutionType solutionType = SolutionType.solution1,
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
          SizedBox(height: SizeConfig.relativeHeight(1.97)),

          Center(
            child: InteractiveViewer(
              maxScale: 10.0,
              child: solutionImages[solutionType]!
                  .image(
                    height: SizeConfig.relativeHeight(
                        solutionDimensions[solutionType]?['height'] ?? 0),
                    width: SizeConfig.relativeWidth(
                        solutionDimensions[solutionType]?['width'] ?? 0),
                  )
                  .wrapPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.relativeWidth(2.67),
                          vertical: SizeConfig.relativeHeight(0.99))),
            ),
          ),
          //
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.80),
                vertical: SizeConfig.relativeHeight(0.68)),
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: CommonTextWidget(
              text: getTitle(solutionType),
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
                vertical: SizeConfig.relativeHeight(0)),
            child: _getSolutionWidget(solutionType),
          ),
        ],
      ),
    ).wrapPadding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(4.80)));
  }

  Widget _getSolutionWidget(SolutionType solutionType) {
    switch (solutionType) {
      case SolutionType.solution1:
        return solution1();
      case SolutionType.solution2:
        return solution2();
      case SolutionType.solution3:
        return solution3();
      case SolutionType.solution4:
        return solution4();
      default:
        return SizedBox.shrink(); // Fallback case
    }
  }

  Widget solution1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        headerText("Lösung :"),

        SizedBox(height: SizeConfig.relativeHeight(3)),
        header1Text("Formel :  "),
        SizedBox(height: SizeConfig.relativeHeight(0.62)),
        Assets.icons.icFormulaThreeNew.image(
            height: SizeConfig.relativeHeight(8),
            width: SizeConfig.relativeWidth(50)),
        dividerWithSpace(),

        descriptionText(solutionDesc1),
        SizedBox(height: SizeConfig.relativeHeight(1.99)),
      ],
    );
  }

  Widget solution4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        headerText("Berechnung der Oszillationsfrequenz f:"),

        SizedBox(height: SizeConfig.relativeHeight(1.48)),
        // SizedBox(height: SizeConfig.relativeHeight(0.62)),
        Assets.icons.icFormulasix.image(
            height: SizeConfig.relativeHeight(16.87),
            width: SizeConfig.relativeWidth(80.57)),
        SizedBox(height: SizeConfig.relativeHeight(0.62)),
        descriptionText("Oder  durch infinity  circuit app    ablesen  "),

        dividerWithSpace(),

        descriptionText(solutionDesc4),
        SizedBox(height: SizeConfig.relativeHeight(1.99)),
      ],
    );
  }

  Widget solution3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        headerText("Wheatstone-Brücke :"),

        SizedBox(height: SizeConfig.relativeHeight(3)),
        header1Text("Formel :  "),
        SizedBox(height: SizeConfig.relativeHeight(0.62)),
        Assets.icons.icFormulafour.image(
            height: SizeConfig.relativeHeight(7.07),
            width: SizeConfig.relativeWidth(24.53)),
        dividerWithSpace(),
        // header1Text("Formel :  "),
        descriptionText("Durchführung:\n"
            "1. Baue die Wheatstone-Brücke mit R = 1 kΩ und einem verstellbaren Potentiometer (V).\n\n"
            "2. Passe den Wert des Potentiometers so an, dass die Spannung an der Brücke diagonal (zwischen den Knoten A und B) null wird.\n\n"
            "3. Wenn die Spannung AB null ist, lies den Wert von R ab. Dieser Wert entspricht dem unbekannten Widerstand."),
        // descriptionText(solutionDesc3),
        Assets.icons.icFormulafive.image(
            height: SizeConfig.relativeHeight(14.07),
            width: SizeConfig.relativeWidth(70.53)),
        SizedBox(height: SizeConfig.relativeHeight(1.99)),
      ],
    );
  }

  Widget solution2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText("Dioden mit LED - Lösung\n"),
        header1Text("Berechnung des Vorwiderstands:"),
        SizedBox(height: SizeConfig.relativeHeight(1.23)),
        descriptionText("Um die LED zu schützen, muss ein Vorwiderstand berechnet werden, der den Strom begrenzt.\n"),
        SizedBox(height: SizeConfig.relativeHeight(1.23)),
        Assets.icons.icFormulatwo.image(
            height: SizeConfig.relativeHeight(5.67),
            width: SizeConfig.relativeWidth(28.58)),
        dividerWithSpace(),

        header1Text("Einsetzen der Werte:"),
        SizedBox(height: SizeConfig.relativeHeight(0.99)),
        Assets.icons.icFormulaTwoNew.image(
            height: SizeConfig.relativeHeight(8),
            width: SizeConfig.relativeWidth(50)),
        SizedBox(height: SizeConfig.relativeHeight(1.99)),

        descriptionText('Wählen Sie den nächsthöheren Standardwert = 100Ω, um die LED zu schützen.\n'),
        header1Text("Verhalten der Schaltung:\n"),
        descriptionText('Bei Verwendung des 100Ω Widerstands wird die LED korrekt betrieben.\n'),
        descriptionText('Verwenden Sie die Infinity Circuit App, um die Spannungs-Strom-Kennlinie der Diode aufzuzeichnen.\n'),
        descriptionText('In der Durchlassrichtung zeigt die Diode eine niedrige Spannung (Vorwärtsspannung), und es fließt Strom.\n'),
        descriptionText('In der Sperrkonfiguration fließt nahezu kein Strom, was an der Sperrwirkung der Diode liegt.\n'),
      ],
    );
  }

  Widget headerText(String text) {
    return CommonTextWidget(
      text: text,
      fontSize: SizeConfig.setSp(14),
      color: AppColors.color212121,
      fontWeight: FontWeight.w600,
    );
  }

  Widget header1Text(String text) {
    return CommonTextWidget(
      text: text,
      fontSize: SizeConfig.setSp(14),
      color: AppColors.color212121,
      fontWeight: FontWeight.w400,
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
        Divider(
          height: 0.5,
          color: AppColors.color212121.withOpacity(0.2),
        ),
        SizedBox(height: SizeConfig.relativeHeight(1.97)),
      ],
    );
  }
}
