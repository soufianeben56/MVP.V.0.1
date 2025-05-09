import 'package:flutter/material.dart';
import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart'; // Stelle sicher, dass Assets generiert sind
import 'package:infinity_circuit/generated/l10n.dart';
import 'howtouse_viewmodel.dart';

/// Map of section IDs to their corresponding GlobalKeys
/// This allows direct navigation to specific sections
class HowToUseSections {
  static const String breadboards = 'breadboards';
  static const String potentiometer = 'potentiometer';
  static const String shuntResistor = 'shunt_resistor';
  static const String otherComponents = 'other_components';
  static const String messboard = 'messboard';
  
  // Add more section IDs as needed
}

class HowToUseView extends StatefulWidget {
  /// If provided, the view will automatically scroll to this section when opened
  final String? initialSectionId;

  const HowToUseView({super.key, this.initialSectionId});

  @override
  State<HowToUseView> createState() => _HowToUseViewState();
}

class _HowToUseViewState extends State<HowToUseView> {
  // Map of section IDs to their GlobalKeys for direct navigation
  final Map<String, GlobalKey> _sectionKeys = {
    HowToUseSections.breadboards: GlobalKey(),
    HowToUseSections.potentiometer: GlobalKey(),
    HowToUseSections.shuntResistor: GlobalKey(),
    HowToUseSections.otherComponents: GlobalKey(),
    HowToUseSections.messboard: GlobalKey(),
    // Add more as needed
  };

  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    
    // If an initial section ID was provided, scroll to it after the layout is complete
    if (widget.initialSectionId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(widget.initialSectionId!);
      });
    }
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  /// Scrolls to the section with the given ID
  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Helper to build image sections consistently
  Widget _buildImageSection(AssetImage imageProvider, {double height = 200}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      padding: const EdgeInsets.all(10.0), // Padding around the image
      color: Colors.white, // Background for the image area
      child: Center(
        child: InteractiveViewer(
          maxScale: 5.0,
          child: Image(
            image: imageProvider,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // Helper for main section titles
  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: CommonTextWidget(
        text: text,
        fontSize: SizeConfig.setSp(18),
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

   // Helper for sub-section titles (like within Wichtige Bauteile)
  Widget _buildSubSectionTitle(String text, {GlobalKey? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: CommonTextWidget(
        text: text,
        fontSize: SizeConfig.setSp(16),
        fontWeight: FontWeight.bold,
         color: Colors.black87,
      ),
    );
  }

  // Helper for regular instruction text points (now handles multi-line)
  Widget _buildInstructionPoint(String text, {double leftPadding = 8.0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0, left: leftPadding),
      child: CommonTextWidget(
        text: text, // Pass the full text, potentially multi-line
        fontSize: SizeConfig.setSp(14),
        fontWeight: FontWeight.w400,
        color: AppColors.color212121.withOpacity(0.8),
        // Ensure CommonTextWidget doesn't limit lines (e.g., no maxLines: 1)
      ),
    );
  }

  // Helper for sub-instruction points (like under DC Messung)
  Widget _buildSubInstructionPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 24.0),
      child: CommonTextWidget(
        text: text.startsWith('o ') ? text.substring(2) : text,
        fontSize: SizeConfig.setSp(14),
        fontWeight: FontWeight.w400,
        color: AppColors.color212121.withOpacity(0.8),
      ),
    );
  }

   // Helper for warning text
  Widget _buildWarning(String title, String content) {
     return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0, left: 8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            CommonTextWidget(
              text: title,
              fontSize: SizeConfig.setSp(14),
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 4),
            CommonTextWidget(
              text: content,
              fontSize: SizeConfig.setSp(14),
               color: AppColors.colorRed.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ],
       ),
     );
   }

  // Helper for best practice / usage text
   Widget _buildBestPractice(String title, String content) {
     return Padding(
       padding: const EdgeInsets.only(top: 12.0, bottom: 8.0, left: 8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CommonTextWidget(
             text: title,
             fontSize: SizeConfig.setSp(14),
             color: Colors.black,
             fontWeight: FontWeight.bold,
           ),
           const SizedBox(height: 4),
           CommonTextWidget(
             text: content,
             fontSize: SizeConfig.setSp(14),
              color: AppColors.color212121.withOpacity(0.8),
             fontWeight: FontWeight.w400,
           ),
         ],
       ),
     );
   }


  @override
  Widget build(BuildContext context) {
    // Data extracted from the old 'instructions' list for clarity
    final breadboardData = {
      'title': 'Breadboards',
      'image': AssetImage(Assets.icons.imgHTU4.path),
      'usage': 'Anwendung:',
      'usageContent': 'Die vertikalen Streifen des Breadboards dienen als Stromschienen für GND und VCC, um eine stabile Stromversorgung sicherzustellen. Platziere die Bauteile so, dass sie die mittlere Trennlinie überbrücken, um Verbindungen auf beiden Seiten zu ermöglichen. Halte Verbindungen so kurz wie möglich, um Fehler zu vermeiden und die Stabilität der Schaltung zu erhöhen.',
    };

     final componentData = {
       'title': 'Wichtige Bauteile',
       'sections': [
         {
           'subtitle': 'Verwendung des Potentiometers',
           'sectionId': HowToUseSections.potentiometer,
           'content': 'Stecke das Potentiometer fest in das Breadboard, verbinde es mit 3.3V und Ground, und miss die Spannung zwischen den beiden Ausgangspins (mittlerer und rechter Pin). Gib den auf dem Potentiometer aufgedruckten Maximalwert (z.B. B5K für 5000 Ohm) in die App ein, die dann den Widerstandswert automatisch berechnet.',
           'image': AssetImage(Assets.icons.imgHTU5.path),
         },
         {
           'subtitle': 'Shunt-Widerstand',
           'sectionId': HowToUseSections.shuntResistor,
           'content': 'Der Shunt-Widerstand wird in der Schaltung verwendet, um den Strom zu messen. Er wird in Reihe mit dem zu messenden Stromkreis geschaltet, und der Spannungsabfall über dem Shunt gibt die Stromstärke an. Der verwendete Shunt hat einen Wert von 1 Ohm, was eine präzise Strommessung ermöglicht.',
           'image': AssetImage(Assets.icons.imgHTU6.path),
         },
         {
           'subtitle': 'Weitere Bauteile',
           'sectionId': HowToUseSections.otherComponents,
           // Ensure the characters are preserved correctly here and add consistent line breaks
           'content': 'Diese Bauteile spielen eine entscheidende Rolle in elektronischen Schaltungen:\n\n'
               'Widerstand: Begrenzt den Stromfluss in der Schaltung.\n\n'
               'Spule: Wird zur Erzeugung magnetischer Felder oder zur Energiespeicherung verwendet.\n\n'
               'Zener-Diode: Stabilisiert die Spannung in der Schaltung.\n\n'
               'Kondensator: Speichert elektrische Energie und wird oft zur Glättung von Spannungen eingesetzt.\n\n'
               'NPN-Transistor: Wird als Schalter oder Verstärker in der Schaltung verwendet.\n\n'
               'LEDs: Leuchtdioden, die bei Stromfluss leuchten; ihre Farbe hängt vom Halbleitermaterial ab.',
           'image': AssetImage(Assets.icons.imgHTU7.path),
         }
       ]
     };


    return ViewModelBuilder<HowToUseViewmodel>.reactive(
      viewModelBuilder: () => HowToUseViewmodel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: "Bedienungsanleitung",
            showAction: false,
          ),
          body: SingleChildScrollView( // Makes the entire content scrollable
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Main Title ---
                CommonTextWidget(
                  text: '📘 Schritt-für-Schritt',
                  fontSize: SizeConfig.setSp(20),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 16),

                // --- Messboard Section ---
                _buildSectionTitle('Messboard'),
                // Add key for messboard section
                Padding(
                  key: _sectionKeys[HowToUseSections.messboard],
                  padding: EdgeInsets.zero,
                  child: _buildImageSection(AssetImage('assets/icons/messboard_pins.PNG')),
                ),
                _buildSubSectionTitle('🔄 Für AC-Messung:'),
                _buildInstructionPoint('1. Sinusspannung einspeisen → Stecke ein Kabel in Reihe 50 (Sinus).'),
                _buildInstructionPoint('2. Schaltung aufbauen (z. B. RLC-Kreis).'),
                _buildInstructionPoint('3. Spannungsmessung:'),
                _buildSubInstructionPoint('Verwende die Punkte AC1 (25) und AC1 (27) um die Spannung zwischen zwei Punkten zu messen.'),
                _buildSubInstructionPoint('Die Differenzspannung liegt an OUT1 (20).'),
                _buildSubInstructionPoint('Verbinde OUT1 mit CH0 (1) → Spannung erscheint in der App.'),
                _buildInstructionPoint('4. Strommessung:'),
                _buildSubInstructionPoint('Verwende die Punkte AC2 (30) und AC2 (32) um den Strom zwischen zwei Punkten zu messen.'),
                _buildSubInstructionPoint('Die Stromdifferenz liegt an OUT2 (22).'),
                _buildSubInstructionPoint('Verbinde OUT2 mit CH2 (10) → Strom erscheint in der App.'),
                const SizedBox(height: 8.0), // Add consistent spacing between measurement sections
                _buildSubSectionTitle('🧷 Für DC-Messung:'),
                _buildInstructionPoint('Spannung messen:'),
                _buildSubInstructionPoint('CH0 (1) = Minuspol'),
                _buildSubInstructionPoint('CH1 (5) = Pluspol'),
                _buildSubInstructionPoint('→ Differenz = CH1 – CH0'),
                _buildInstructionPoint('Strom messen:'),
                _buildSubInstructionPoint('CH2 (10) = Minuspol (vor dem Shunt)'),
                _buildSubInstructionPoint('CH3 (15) = Pluspol (nach dem Shunt)'),
                _buildSubInstructionPoint('→ Differenz = CH3 – CH2'),
                _buildSubInstructionPoint('Hinweis: Die Reihen 25–32, 20, und 50 werden bei DC nicht benötigt.'),
                const SizedBox(height: 8.0), // Add consistent spacing before pin descriptions
                _buildSubSectionTitle('🛠 Weitere Hinweise'),
                _buildInstructionPoint('• DAC (35): Wird zur automatischen Diodensteuerung genutzt'),
                _buildInstructionPoint('• GND (40): Immer verbinden, gemeinsam mit Signalmasse'),
                _buildInstructionPoint('• EN (45): Reset für Bluetooth'),
                _buildInstructionPoint('• 3,3 V (55): Für DC-Schaltungen, Sensoren, OPVs etc.'),
                _buildInstructionPoint('• 5 V (60): Für leistungsstärkere Module'),
                const SizedBox(height: 8.0), // Add consistent spacing after pin list

                // Add consistent spacing between the sections
                const SizedBox(height: 16),
                
                // --- Breadboards Section (Existing Content) ---
                _buildSectionTitle(breadboardData['title'] as String),
                // Add key for breadboards section
                Padding(
                  key: _sectionKeys[HowToUseSections.breadboards],
                  padding: EdgeInsets.zero,
                  child: _buildImageSection(breadboardData['image'] as AssetImage),
                ),
                _buildBestPractice(breadboardData['usage'] as String, breadboardData['usageContent'] as String),

                // Add consistent spacing between the sections
                const SizedBox(height: 16),
                
                // --- Wichtige Bauteile Section (Corrected Content Handling) ---
                _buildSectionTitle(componentData['title'] as String),
                for (var section in componentData['sections'] as List<Map<String, dynamic>>) ...[
                   _buildSubSectionTitle(
                     section['subtitle'] as String,
                     // Add key for each component section
                     key: _sectionKeys[section['sectionId'] as String],
                   ),
                   _buildImageSection(section['image'] as AssetImage),
                   // Pass the entire content string to one widget with consistent padding
                   _buildInstructionPoint(
                       (section['content'] as String).trim(),
                       leftPadding: 12.0 
                   ),
                   const SizedBox(height: 16.0), // Consistent spacing between component subsections
                ],

                // Consistent bottom padding
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
