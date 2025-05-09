import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppConstants {
  static String appVersion = "";

  /// BLE Characteristics
  static const String bleServiceUUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";

  ///  device info UUID's
  static const String deviceInfoUUID = "180A";

  /// battery info UUID's
  static const String batteryServiceUUID = "180F";
  static const String batteryLevelUUID = "2A19";

  /// device info UUID's
  static Guid deviceInfoServiceUUID = Guid("180A");
  static Guid manufactureNameUUID = Guid("2A29");
  static Guid modelNumberUUID = Guid("2A24");
  static Guid serialNumberUUID = Guid("2A25");
  static Guid hardwareRevisionUUID = Guid("2A27");
  static Guid softwareRevisionUUID = Guid("2A28");
  static Guid firmwareRevisionUUID = Guid("2A26");

  /// UART over BLE UUID's
  static Guid rxServiceUUID = Guid("6E400002B5A3F393E0A9E50E24DCCA9E");
  static Guid txServiceUUID = Guid("6E400003B5A3F393E0A9E50E24DCCA9E");
}

const String stringExpTitle1 = "RLC";
const String stringExpTitle2 = "Dioden mit LED";
const String stringExpTitle3 = "Brückenschaltung";
const String stringExpTitle4 = "Multivibrator";
const String stringExpDescription1 =
    "Untersuchung des Verhaltens einer in Reihe geschalteten RLC-Schaltung, insbesondere der Resonanzfrequenz und Spannungsstabilität.";
const String stringExpDescription1New =
    "Untersuchung des Verhaltens einer in Reihe geschalteten RLC-Schaltung, insbesondere der Resonanzfrequenz und Phasenvershiebung.";
const String stringExpDescription2 =
    " Kennlinien von Diode und LED vergleichen, den Unterschied der Schwellenspannung beobachten und die praktische Berechnung eines LED-Schutzwiderstands durchführen.";
const String stringExpDescription3 =
    "Bestimmung eines unbekannten Widerstands mit einer Wheatstone-Brücke.";

//
const String strZiel = "Ziel : ";
const String strBenotigteMaterialien = "Benötigte Materialien :";
const String strAnleitung = "Anleitung : ";
const String strSicherheitshinweise = "Sicherheitshinweise :";
const String strFragenZurUntersuchung = "Fragen zur Untersuchung :";

//
const String strZielDesc1 =
    "Untersuchung des Verhaltens einer in Reihe geschalteten RLC-Schaltung, insbesondere der Resonanzfrequenz und SpannungssPhasenvershiebung.";
const String strZielDesc2 =
    "Untersuchung der Strom-Spannungs-Kennlinie einer Diode und LED. Ziel ist es, das Verhalten der Diode und LED zu analysieren und den Unterschied der Schwellenspannung zu beobachten.";
const String strZielDesc3 =
    "Bestimmung eines unbekannten Widerstands mit einer Wheatstone-Brücke.";

//
const String strBenotigteMaterialien1 = "AC-Signal: +1.45V bis -1.45V\n"
    "Widerstand: 68 Ω\n"
    "Spule (L): 4.7 mH\n"
    "Kondensator (C): 220 µF\n"
    "Shunt-Widerstand: 5 Ω  (zur Strommessung ).\n"
    "Verbindungskabel.\n"
    ;

const String strBenotigteMaterialien2 =
    "Spannungsquelle: DAC (über Messboard-Reihe 35 und NICHT von 55)\n"
    "Diode + LED (rote LED mit 2V, 20mA)\n"
    "Shunt-Widerstand: 1Ω  (für Strommessung)\n"
    "4 Messleitungen: CH0-CH3 (Messboard-Reihe 1, 5, 10, 15)\n";

const String strBenotigteMaterialien3 = "R1 : 1 kΩ (Festwiderstand)\n"
    "R1 & R2: je 1kΩ (Festwiderstände)\n"
    "R4: unbekannter Widerstand (zu bestimmen)\n"
    "VR1 Potentiometer,  (veränderbarer Widerstand)\n"
    "Spannungsquelle 3.3 V über Messboard-Reihe 55\n"
    "Messleitungen: Messleitungen: CH0 = Messboard-Reihe 1, CH1 = Messboard-Reihe 5";

const String strBenotigteMaterialien4 = "2 x NPN-Transistoren\n"
    "2 x LEDs.\n"
    "2 x Widerstände für die Basis = 10 kΩ:\n"
    "2 x Widerstände für die LEDs ,= 330 Ω :\n"
    "2 x Kondensatoren , = 330 10 µF:\n"
    "1 x Breadboard.\n"
    "Verbindungskabel.\n"
    "3.3V SpannungQuelle.\n"
    "Messverbindung mit CH0/CH1 falls benötigt";

//
const String strAnleitung1 =
    "Versorge die Schaltung über Messboard-Reihe 50 (Sinusversorgung).\n"
    "2. Setze einen  100 \u202F\u03A9 Widerstand in Reihe zum Eingangssignal.\n"
    "3. Schließe Spule und Kondensator im Reihe zur Sinusquelle an.\n"
    "4. Füge den 5\u202F\u03A9 Shunt-Widerstand in den Stromkreis ein.\n"
    "5. Spannungsmessung:\n"
    "• Verwende Reihe 25 und 27 (AC1) um die Spannung zwischen zwei Punkten zu messen.\n"
    "• Die Differenzspannung liegt an OUT1 (Reihe 20).\n"
    "• Verbinde OUT1 mit CH0 (Reihe 1) \u2192 Spannung erscheint in der App.\n"
    "6. Strommessung:\n"
    "• Verwende Reihe 30 und 32 (AC2) um den Strom zwischen zwei Punkten zu messen.\n"
    "• Die Stromdifferenz liegt an OUT2 (Reihe 22).\n"
    "• Verbinde OUT2 mit CH2 (Reihe 10) \u2192 Strom erscheint in der App.\n"
    "7. Starte die App, um Spannung und Strom gleichzeitig als Kurve zu sehen und die Phasenverschiebung zu analysieren.";
const String strAnleitung2 =
    "1. Bauen Sie die Schaltung nach dem Schaltplan auf dem Breadboard auf.\n\n"
    "2. Füge den Shunt-Widerstand in Reihe ein - zur Strommessung\n\n"
    "3. Verbinde den Shunt mit den Messpunkten, um den Strom durch die Diode zu ermitteln\n"
    "   o CH2 (Messboard-Reihe 1) = Minus-Seite \n "
    "   o CH3 (Messboard-Reihe 5) = Plus-Seite \n\n"
    "4. Verwenden Sie die Infinity Circuit App, um die Spannungs-Strom-Kennlinie der Diode und LED zu analysieren und zu visualisieren.";

const String strAnleitung3 =
    "1.Bauen Sie die Wheatstone-Brücke mit den vier Widerständen auf dem Breadboard auf.\n\n"
    "2.Verbinden Sie CH0 (Messboard-Reihe 1) und CH1 (Messboard-Reihe 5), um die Spannung zwischen den Punkten A und B der Brücke zu messen\n\n"
    "3.Verwenden Sie die Infinity Circuit App, um den unbekannten Widerstand zu berechnen.";


const String strAnleitung4 = " 1. Haltung 	betreiben :"
    "Verbinde die Schaltung mit der 3.3V  SpannungQuelle."
    "Beobachte, 	wie die LEDs abwechselnd blinken. Die Blinkgeschwindigkeit wird 	durch die Werte von R,C,L und T bestimmt."
    "2.Analyse :"
    "Variiere die Werte von R,C,L und T um zu sehen, wie sich die Frequenz des Blinksignals ändert."
    "Verwende die Infinity Circuit App, um die Frequenz des erzeugten 	Rechtecksignals zu messen und zu analysieren.";

//
const String strSicherheitshinweise1 =
    "Stellen Sie sicher, dass alle Verbindungen sicher sind, bevor Sie die Schaltung mit Strom versorgen.\n\n"
    "Beachten Sie, dass das AC-Signal über Messboard-Reihe 50 eingespeist wird \n\n"
    "Wenn Sie einen ungewöhnlichen, verbrannten Geruch wahrnehmen oder , trennen Sie das USB-Kabel sofort.";

const String strSicherheitshinweise2 =
    "• Die Versorgungsspannung in diesem Versuch wird über Messboard-Reihe 35 (DAC) bereitgestellt.\n"
    "• Stellen Sie sicher, dass alle Verbindungen korrekt sind, bevor Sie die Spannung anschließen. ";

const String strSicherheitshinweise3 =
    "•	Stellen Sie sicher, dass alle Verbindungen korrekt sind, um Kurzschlüsse zu vermeiden.";

//

const String strFragenZurUntersuchung1 =
    "Berechnen Sie die Resonanzfrequenz der in Reihe geschalteten RLC-Schaltung sowohl rechnerisch als auch experimentell. Wie verhält sich die gemessene Resonanzfrequenz im Vergleich zur berechneten?\n\n"
    "Wie groß ist die Phasenverschiebung zwischen Spannung und Strom im reinen Widerstand?\n\n"
    "Was passiert mit der Phasenlage, wenn eine Kondensator anstelle des Widerstands verwendet wird?";
const String strFragenZurUntersuchung2 =
    "Berechnen Sie den Vorwiderstand, um die LED zu schützen, insbesondere im Fall der Sperrstromrichtung.\n\n"
    "Diskutieren Sie, was passiert, wenn der Vorwiderstand kleiner als der richtige Wert gewählt wird und welche Auswirkungen dies auf die Diode und LED haben könnte.\n\n"
    "Vergleiche die Kennlinie der normalen Diode mit der LED-Kennlinie. Welchen charakteristischen Unterschied erkennst du, und welche physikalische Eigenschaft der LED wird dadurch sichtbar?\n";
const String strFragenZurUntersuchung3 =
    "Bestimmen Sie den unbekannten Widerstand!\n\n"
    
    "Welche Faktoren können die Genauigkeit der Widerstandsmessung beeinflussen?";
const String strFragenZurUntersuchung4 =
    "Wie kann die Leuchtdauer der beiden LEDs gleich sein?\n\n"
    "Welche Faktoren beeinflussen die Leuchtdauer der LEDs?\n\n"
    "Wie wird die erzeugte Frequenz berechnet?\n";

//

const String solutionDesc1 =
    "Durchführung:\nVariieren Sie die Frequenz im Bereich von 100 Hz bis 200 Hz, um die Resonanzfrequenz zu finden. Beobachten Sie dabei, bei welcher Frequenz der Strom durch die Schaltung am größten ist.\n\n"
    "Nutzen Sie die Infinity Circuit App, um den Strom in Abhängigkeit von der Frequenz zu messen und die Resonanzfrequenz zu identifizieren.\n\n"
    "Erwartung:\nDie größte Stromstärke sollte bei etwa 156 Hz bis 158 Hz liegen. Abweichungen können durch reale Bauteiltoleranzen und parasitäre Effekte entstehen.\n\n"
    "Phasenverschiebung:\nDie Phasenverschiebung im Widerstand sollte 0° betragen, während zwischen Widerstand und Kondensator eine Phasenverschiebung von 90° auftreten sollte. Hinweis: Die Richtung von Anschlüssen könnte auch -90° ergeben.";

const String solutionDesc2 =
    "Dioden mit LED - Lösung:\n\n"
    "Berechnung des Vorwiderstands:\n"
    "Um die LED zu schützen, muss ein Vorwiderstand berechnet werden, der den Strom begrenzt.\n\n"
    "Verhalten der Schaltung:\n"
    "Bei Verwendung des 100\u03A9 Widerstands wird die LED korrekt betrieben.\n"
    "Die LED sollte konstant leuchten, was auf eine stabile Stromversorgung hindeutet.\n"
    "Verwenden Sie die Infinity Circuit App, um die Spannungs-Strom-Kennlinie der Diode und LED aufzuzeichnen.\n"
    "In der Durchlassrichtung zeigt die Diode eine niedrige Spannung (Vorwärtsspannung), und es fließt Strom.\n"
    "In der Sperrkonfiguration fließt nahezu kein Strom, was an der Sperrwirkung der Diode liegt.";

const String solutionDesc3 = "Durchführung:\n"
    "1. Baue die Wheatstone-Brücke mit R = 1 kΩ und einem verstellbaren Potentiometer (V).\n\n"
    "2. Passe den Wert des Potentiometers so an, dass die Spannung an der Brücke diagonal (zwischen den Knoten A und B) null wird.\n\n"
    "3. Wenn die Spannung AB null ist, lies den Wert von R ab. Dieser Wert entspricht dem unbekannten Widerstand.";

const String solutionDesc4 = "Verhalten der Schaltung:\n"
    "Die LEDs blinken abwechselnd mit einer Frequenz von 7,2 Hz.\n\n"
    "Durch Ändern der Werte von Widerstand oder Kondensator kann die Frequenz und Dauer der LED-Leuchtphasen beeinflusst werden.";
const String stringTutorialTitle1 = "RLC-Schaltungs tutorial";
const String strEinfuhrung = "Einführung :  ";
const String strAnforderungsmetrik = "Anforderungsmetrik :  ";
const String strWiemanExperimentedurchfuhrt =
    "Wie man Experimente durchführt :   ";
//
const String strEinfuhrung1 = "Lorem ipsum dolor sit amet consectetur. Sapien"
    "risus tincidunt neque aliquam eleifend proin justo."
    "Leo eleifend viverra at volutpat eget quis duis eget nisl mattis.;";
const String strAnforderungsmetrik1 =
    "Lorem ipsum dolor sit amet consectetur. Sapien "
    "risus tincidunt neque aliquam eleifend proin justo. "
    "Leo eleifend viverra at volutpat eget quis duis eget "
    "nisl mattis.";
const String strWiemanExperimentedurchfuhrt1 =
    'Lorem ipsum dolor sit amet consectetur. Sapien '
    'risus tincidunt neque aliquam eleifend proin justo. '
    'Leo eleifend viverra at volutpat eget quis duis '
    'eget nisl mattis. Lorem ipsum dolor sit amet '
    'consectetur. Sapien risus tincidunt neque '
    'aliquam eleifend proin justo. Leo eleifend viverra '
    'at volutpat eget quis duis eget nisl mattis. Lorem '
    'ipsum dolor sit amet consectetur. Sapien risus '
    'tincidunt neque aliquam eleifend proin justo. Leo '
    'eleifend viverra at volutpat eget quis duis eget '
    'nisl mattis.';

const String strAbmelden = "Abmelden";
const String strAbmelden1 =
    'Sind Sie sicher, dass Sie sich von diesem Konto abmelden möchten?';

const String strEntschuldigung = "Entschuldigung";
const String strEntschuldigung1 = "Ihr Gerät ist nicht verbunden..!";
const String strMaximaleSpannungsundStromwerte =
    "Maximale Spannungs- und Stromwerte:";
const String strMaximaleSpannungsundStromwerte1 =
    "Verwende niemals mehr als 5V Spannung und stelle sicher, dass der Strom 500mA nicht überschreitet.";
const String strSchutzderBauteile1 =
    "Achte auf die richtige Polung und den korrekten Anschluss von Bauteilen wie Transistoren, Dioden, Kondensatoren und Widerständen."
    "Verwende Schutzmaßnahmen wie Spannungsregler, um die Komponenten vor Überspannung zu schützen."
    "Nutze nicht die folgenden Pins: CLK, D0, D1, CMD, D3, D2.";
const String strstrschutzderBauteile1 =
    "Achte auf die richtige Polung und den korrekten Anschluss von Bauteilen wie Transistoren, Dioden, Kondensatoren und Widerständen."
    "Verwende Schutzmaßnahmen wie Spannungsregler, um die Komponenten vor Überspannung zu schützen."
    "Nutze nicht die folgenden Pins: CLK, D0, D1, CMD, D3, D2.";

const String strSchutzderBauteile = "SchutzderBauteile:";
const String strVermeidungvonKurzschlussen = "Vermeidung von Kurzschlüssen:";
const String strVermeidungvonKurzschlussen2 =
    "Stelle sicher, dass keine offenen Drähte oder unsicheren Verbindungen vorhanden sind, "
    "um Kurzschlüsse zu verhindern.";
const String strSichererUmgangmitderSchaltung =
    "Sicherer Umgang mit der Schaltung:";
const String strSichererUmgangmitderSchaltung1 =
    "Schalte die Stromversorgung sofort ab, wenn du Rauch, ungewöhnliche Gerüche oder übermäßige Hitzeentwicklung bemerkst."
    "Überprüfe jede Änderung an der Schaltung gründlich, bevor du die Spannung wieder anlegst.";
const String strVerwendungderESP32Pins = "Verwendung der Pins:";
const String strVerwendungderESP32Pins1 =
    "Nutze nicht die folgenden Pins: CLK, D0, D1, CMD, D3, D2.";

const String strMaximaleSpannungsUndStromwerte =
    "MaximaleSpannungsundStromwerte:";
const String strMaximaleSpannungsUndStromwerte1 =
    "Verwende niemals mehr als 5V Spannung und stelle sicher, dass der Strom 500mA nicht überschreitet.";

const String strvermeidungvonKurzschlussen = "Vermeidung von Kurzschlüssen:";
const String strVermeidungvonKurzschlussen1 =
    "Stelle sicher, dass keine offenen Drähte oder unsicheren Verbindungen "
    "vorhanden sind, um Kurzschlüsse zu verhindern.";

const String strVerwendungderADCPins = "Verwendung der ADC-Pins:";
const String strVerwendungderADCPins1 =
    "Messe Spannungen über die ADC-Pins nur bis maximal 3,3V. Nutze Spannungsregler, um die "
    "Spannung sicher zu reduzieren.";
const String strWichtigerHinweis = "Wichtiger Hinweis:";
const String strWichtigerHinweis1 =
    "Lese sorgfältig die Seite Wie zu verwenden durch, bevor du mit der App arbeitest.";

const String struberblick =
    "Der ESP32 ist ein leistungsstarker Mikrocontroller mit verschiedenen digitalen und analogen Anschlüssen. Dieser Leitfaden hilft dir, die wichtigsten Funktionen und Anschlüsse des ESP32 korrekt zu nutzen, um erfolgreiche Experimente durchzuführen.";
//const String strstrHinweis = " Achte darauf, die Anschlüsse korrekt zu verwenden, um Schäden an deinem ESP32 und anderen Bauteilen zu vermeiden.";
const String strFrequencySelection = "Frequency Selection:";
const String strFrequencySelection1 =
    " Verwende Pin 25, um die Frequenz zu steuern.";

const String strHinweiss = "Hinweis:";
const String strHinweis11 =
    " Achte darauf, die Anschlüsse korrekt zu verwenden, um Schäden an deinen Bauteilen zu vermeiden.";

const String strVoltageMeasurement = "Voltage Measurement:";
const String strVoltageMeasurement1 =
    "Nutze die Pins 32 und 33, um Spannungen zu messen.";

const String strCurrentMeasurement = "Current Measurement:";
const String strCurrentMeasurement1 =
    "Verwende die Pins 34 und 35, um den Strom zu messen.";

const String strSinewaveGeneration = "Sinewave Generation:";
const String strSinewaveGeneration1 =
    "Verwende Pin 25, um eine Sinuswelle zu erzeugen.";

const String strPWMfurDiodeInputVoltage = "PWM für Diode Input Voltage:";
const String strPWMfurDiodeInputVoltage1 =
    "Verwende Pin 26, um PWM für die Dioden-Eingangsspannung zu generieren.";

const String strSpannungsmessung = "Spannungsmessung:";
const String strSpannungsmessung1 =
    "  Verbinde die zu messende Spannung mit den Pins 32 und 33. Achte darauf, dass die Spannung 3.3V nicht überschreitet. Nutze Spannungteiler , um höhere Spannungen sicher zu messen.";

const String strStrommessung = "Strommessung:";
const String strStrommessung1 =
    " Ein 1-Ohm-Shunt-Widerstand wird in Reihe mit dem zu messenden Bauteil geschaltet. Der Spannungsabfall über den Shunt-Widerstand wird dann über die Pins 34 und 35 gemessen, um den Strom zu berechnen.";

const String strGrundprinzip = "Grundprinzip:";
const String strGrundprinzip1 =
    "Ein Breadboard ist ein wiederverwendbares Steckbrett, das zur einfachen und schnellen Erstellung von Schaltungen verwendet wird, ohne dass gelötet werden muss. Es besteht aus vielen kleinen Löchern, in die Drähte und Komponenten gesteckt werden können.";

const String strInterneVerbindungen = "Interne Verbindungen:";
const String strInterneVerbindungen1 =
    "Das Breadboard ist so gebaut, dass die Löcher in Reihen und Spalten miteinander verbunden sind. Es gibt jedoch eine wichtige Trennlinie in der Mitte des Breadboards, die die beiden Hälften elektrisch voneinander trennt. Dies bedeutet, dass Komponenten, die auf der linken Seite platziert sind, nicht automatisch mit denen auf der rechten Seite verbunden sind, es sei denn, du stellst eine Verbindung her.";

const String strPlazierungdesESP32 = "Plazierung auf dem Breadboard:";
const String strPlazierungdesESP321 =
    "Die Beuteil sollte so auf dem Breadboard plaziert werden, dass es die Trennlinie in der Mitte überbrückt. Dies erleichtert die Verbindung der Pins mit den anderen Komponenten auf beiden Seiten des Breadboards.";

const String strStromschienen = "Stromschienen:";
const String strStromschienen1 =
    "Die langen horizontalen Linien oben und unten auf dem Breadboard sind normalerweise als Stromschienen (für VCC und GND) ausgelegt. Diese Schienen verlaufen entlang der gesamten Länge des Breadboards und können verwendet werden, um Spannungen und Masseverbindungen zu verteilen.";

const String strWertbestimmung = "Wertbestimmung:";
const String strWertbestimmung1 =
    "Entferne das Potentiometer aus der Schaltung. Miss die Spannung zwischen dem mittleren Anschluss (Ausgang) und VCC. Gib diesen Spannungswert sowie den auf dem Potentiometer aufgedruckten Maximalwert (z.B. B5K für 5000 Ohm) in die App ein. Die App berechnet automatisch den Widerstandswert.";

const String strHinweis = "Hinweis:";
const String strHinweis1 =
    "Achte darauf, dass das Potentiometer korrekt ausgerichtet und verbunden ist.";

const String strStromversorgunguberUSB = "StromversorgunguberUSB:";
const String strStromversorgunguberUSB1 =
    "Einige Experimente erfordern die Verwendung der 3.3V-Versorgungsspannung anstelle der 5V-USB-Versorgung. Beachte bitte die spezifische Anleitung für jedes Experiment. In solchen Fällen sollte der USB-Anschlussnicht angeschlossen sein, um Fehlmessungen zu vermeiden.";

const String strSpannungsversorgung = "Spannungsversorgung:";
const String strSpannungsversorgung1 =
    "Wenn die Spannung durch das Board bereitgestellt wird, sollte sie über den 3.3V-Pin und den GND-Pin erfolgen. Diese Pins bieten eine stabile 3.3V-Versorgungsspannung, die für die meisten Experimente ausreichend ist.";

const String strLesedieAnleitungsorgfaltig = "Lese die Anleitung sorgfältig:";
const String strLesedieAnleitungsorgfaltig1 =
    "Bevor du mit einem Experiment beginnst, lies bitte die Anleitung und stelle sicher, dass du die Schritte und ";
