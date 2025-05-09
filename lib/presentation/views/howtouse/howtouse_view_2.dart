import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'package:infinity_circuit/generated/l10n.dart';

import 'howtouse_viewmodel.dart';

class HowToUseView extends StatelessWidget {
  const HowToUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HowToUseViewmodel>.reactive(
      viewModelBuilder: () => HowToUseViewmodel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: S.current.Wiezuverwenden,
            showAction: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1 - Introduction
                  CommonTextWidget(
                    text: '1. Einführung in den ESP32 und seine Anschlüsse',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.left,
                  ),

                  SizedBox(
                    width: 18,
                    height: 20,
                  ),
                  // Image
                  Center(
                    child: Container(
                      child: Assets.icons.icHowtouse1.image(
                        height: SizeConfig.relativeHeight(40),
                        width: SizeConfig.relativeWidth(100),
                      ),
                    ),
                  ),
                  // Divider(color: AppColors.black.withOpacity(0.16), thickness: 1.0),
                  SizedBox(height: 20),
                  // Section 2 - Uberblick
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Uberblick :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: struberblick,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Hinweis :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strHinweis11,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),
                  SizedBox(height: 10),

                  // Important Pins Section
                  CommonTextWidget(
                    text: '2. Wichtige Pins für die Experimente',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Frequency Selection :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          // textAlign: TextAlign.justify,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strFrequencySelection1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Voltage Measurement:',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strVoltageMeasurement1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Current Measurement:',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strCurrentMeasurement1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Sinewave Generation :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strSinewaveGeneration1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'PWM für Diode Input Voltage :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strPWMfurDiodeInputVoltage1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),
                  // Section 3
                  CommonTextWidget(
                    text: '3. Messungen mit dem ESP32',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Spannungs messung :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strSpannungsmessung1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Strommessung :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strStrommessung1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),

                  CommonTextWidget(
                    text: '4. Aufbau der Schaltung auf dem Steckbrett',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.left,
                  ),

                  SizedBox(height: 10),
                  // Image
                  Container(
                    child: Assets.icons.icHowtouse2.image(
                      height: SizeConfig.relativeHeight(20),
                      width: SizeConfig.relativeWidth(100),
                    ),
                  ),
                  CommonTextWidget(
                    text: S.current.VerwendungdesBreadboards,
                    color: AppColors.color212121,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.setSp(12),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Grundprinzip :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strGrundprinzip1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Interne Verbindungen :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strInterneVerbindungen1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Plazierung des ESP32 :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strPlazierungdesESP321,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Stromschienen :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strStromschienen1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),

                  CommonTextWidget(
                    text:
                        '5. Verwendung des Potentiometers in der Brückenschaltung',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.left,
                  ),

                  // Image
                  Container(
                    child: Assets.icons.icHowtouse5.image(
                      height: SizeConfig.relativeHeight(30),
                      width: SizeConfig.relativeWidth(200),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Wertbestimmung:',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strWertbestimmung1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Hinweis :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strHinweis1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),

                  CommonTextWidget(
                    text: '6. Wichtige Hinweise zur Stromversorgung',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Stromversorgung über USB :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strStromversorgunguberUSB1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  CommonTextWidget(
                    text: 'Stromversorgung des ESP32:',
                    fontSize: SizeConfig.setSp(12),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                  ),

                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Spannungsversorgung :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strSpannungsversorgung1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),
                  CommonTextWidget(
                    text: '7. Sicherheitshinweise',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Maximale Spannungs- und Stromwerte :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strMaximaleSpannungsUndStromwerte1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Schutz der Bauteile :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strSchutzderBauteile1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.relativeHeight(2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Verwendung der ESP32-Pins :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strVerwendungderESP32Pins1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                          // textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Divider(
                      color: AppColors.black.withOpacity(0.16), thickness: 1.0),

                  // Other sections as needed...

                  // Final section
                  CommonTextWidget(
                    text: '8. Abschluss und Anwendung',
                    fontSize: SizeConfig.setSp(14),
                    fontWeight: FontWeight.w700,
                    color: AppColors.color212121,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(2)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonTextWidget(
                          text: 'Lese die Anleitung sorgfältig :',
                          fontWeight: FontWeight.w700,
                          color: AppColors.color212121,
                          fontSize: SizeConfig.setSp(11),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: CommonTextWidget(
                          text: strLesedieAnleitungsorgfaltig1,
                          fontSize: SizeConfig.setSp(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.color212121.withOpacity(0.60),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
