import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/fonts.gen.dart';
import 'package:infinity_circuit/presentation/views/safety/safety_viewmodel.dart';

import '../../../generated/assets.gen.dart';

class SafetyView extends StatelessWidget {
  const SafetyView({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> sections = [
      {
        'heading': '🔌 Maximale Spannungs- und Stromwerte:',
        'description': 'Verwende niemals mehr als 5 V Spannung und stelle sicher, dass der Strom 500 mA nicht überschreitet.',
      },
      {
        'heading': '🛡️ Schutz der Bauteile:',
        'description': 'Achte auf die richtige Polung und den korrekten Anschluss von Bauteilen wie Transistoren, Dioden, Kondensatoren und Widerständen.\nVerwende Schutzmaßnahmen wie Spannungsregler, um empfindliche Bauteile vor Überspannung zu schützen.',
      },
      {
        'heading': '⚡ Vermeidung von Kurzschlüssen:',
        'description': 'Stelle sicher, dass keine offenen Drähte oder unsicheren Verbindungen vorhanden sind, um Kurzschlüsse zu verhindern.',
      },
      {
        'heading': '🔥 Sicherer Umgang mit der Schaltung:',
        'description': 'Schalte die Stromversorgung sofort ab, wenn du Rauch, ungewöhnliche Gerüche oder übermäßige Hitzeentwicklung bemerkst.\nÜberprüfe jede Änderung an der Schaltung gründlich, bevor du die Spannung wieder anlegst.',
      },
      {
        'heading': '📝 Wichtiger Hinweis:',
        'description': 'Lese sorgfältig die Seite „Wie zu verwenden" durch, bevor du mit der App arbeitest.',
      },
    ];

    return ViewModelBuilder<SafetyViewmodel>.reactive(
      viewModelBuilder: () => SafetyViewmodel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: 'Sicherheitsunterweisung',
            showLeading: false,
            showAction: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 20, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.relativeHeight(0.1)),
                  Center(
                    child: Assets.svg.icDanger.svg(
                        height: SizeConfig.relativeHeight(15),
                        width: SizeConfig.relativeWidth(20)),
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(1)),

                  // Dynamic column for headings and descriptions
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sections.map((section) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            CommonTextWidget(
                              text: section['heading']!,
                              fontWeight: FontWeight.w700,
                              color: AppColors.color212121,
                              fontSize: SizeConfig.setSp(15),
                            ),

                            // For the first description, use RichText to format "5V" and "500mA"
                            if (section['heading'] ==
                                '🔌 Maximale Spannungs- und Stromwerte:')
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: SizeConfig.setSp(13),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.color212121,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Verwende niemals mehr als  ',
                                      style: TextStyle(
                                        fontSize: SizeConfig.setSp(15),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.color212121
                                            .withOpacity(0.60),
                                        fontFamily: FontFamily.poppins,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '5V', // Making 5V bold
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontSize: SizeConfig.setSp(15),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' Spannung und stelle sicher, dass der Strom  ',
                                      style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.color212121
                                              .withOpacity(0.60),
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontSize: SizeConfig.setSp(15)),
                                    ),
                                    TextSpan(
                                      text: '500mA', // Making 500mA bold
                                      style: TextStyle(
                                          fontSize: SizeConfig.setSp(15),
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    TextSpan(
                                      text: ' nicht überschreitet.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.color212121
                                            .withOpacity(0.60),
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontSize: SizeConfig.setSp(15),
                                      ),
                                    ),
                                  ],
                                ),
                                // textAlign: TextAlign.justify,
                              )
                            else if (section['heading'] == '🛡️ Schutz der Bauteile')
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: SizeConfig.setSp(13),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.color212121,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Achte auf die richtige Polung und den korrekten Anschluss von Bauteilen wie Transistoren, Dioden, Kondensatoren und Widerständen.\nVerwende Schutzmaßnahmen wie Spannungsregler, um empfindliche Bauteile vor Überspannung zu schützen.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          color: AppColors.color212121
                                              .withOpacity(0.60),
                                          fontSize: SizeConfig.setSp(15)),
                                    ),
                                    TextSpan(
                                      text:
                                          'ESP32-Pins: CLK, D0, D1, CMD, D3, D2',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          height: 1.5,
                                          fontSize: SizeConfig.setSp(15)),
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              )
                            // Default description formatting
                            else
                              CommonTextWidget(
                                text: section['description']!,
                                fontSize: SizeConfig.setSp(13),
                                fontWeight: FontWeight.w400,
                                color: AppColors.color212121.withOpacity(0.60),
                                // textAlign: TextAlign.justify,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: SizeConfig.relativeHeight(3)),
                  CommonAppButton(
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutePaths.homeViewRoute);
                    },
                    title: 'Überspringen',
                    width: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
