import '../../../exports.dart';
import '../connect_blue/blue_manager.dart';
import 'measurement_graph_view_model.dart';

class RMaxInputDialog extends StatefulWidget {
  final Function(double, double) onRMaxSubmitted;
  final double? latestVoltage;

  const RMaxInputDialog({
    super.key,
    required this.onRMaxSubmitted,
    this.latestVoltage,
  });

  @override
  State createState() => _RMaxInputDialogState();
}

class _RMaxInputDialogState extends State<RMaxInputDialog> {
  final TextEditingController _rMaxController = TextEditingController();
  double? rxValue;
  bool isCalculating = false;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) print("RMaxInputDialog initialized.");

    isConnected = BLEManager().isDeviceConnected();
    BLEManager().connectionStatus.addListener(_onConnectionStatusChanged);
  }

  void _onConnectionStatusChanged() {
    if (!BLEManager().isDeviceConnected()) {
      if (kDebugMode) print("Device disconnected while dialog open. Closing dialog.");

      setState(() {
        isConnected = false;
        rxValue = null;
      });

      Navigator.of(context).pop();

      Future.microtask(() => _showConnectionDialog(context));
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  void _showConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Verbindung erforderlich",
            style: TextStyle(
              color: AppColors.color212121,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Du bist mit keinem Gerät verbunden.",
            style: TextStyle(
              color: AppColors.textColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Abbrechen",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RoutePaths.newScanDeviceViewRoute);
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "Verbinden",
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void calculateRxValue(double rMax) {
    // Check BLE connection first
    if (!BLEManager().isDeviceConnected()) {
      setState(() {
        isConnected = false;
        rxValue = null;
        isCalculating = false;
      });
      if (kDebugMode) print("Device not connected. Cannot calculate Rx value.");
      return;
    }

    setState(() {
      isCalculating = true;
      isConnected = true;
    });

    const double uMax = 3.3; // Maximum voltage
    final double? ux = widget.latestVoltage; // Use voltage passed to the dialog

    if (ux == null) {
      setState(() {
        rxValue = null;
        isCalculating = false;
      });
      if (kDebugMode) print("No voltage data available for Rx calculation.");
      return;
    }

    double calculatedRx = (ux / uMax) * rMax;
    
    setState(() {
      rxValue = calculatedRx; // Rx calculation
      isCalculating = false;
    });

    if (kDebugMode) print("RMax calculated using voltage $ux: Rx = $rxValue");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header mit Schließen-Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rmax Wert eingeben",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 8),
            
            // Anleitung als aufklappbares Panel
            ExpansionTile(
              title: Text("Anleitung", style: TextStyle(fontSize: 14)),
              initiallyExpanded: false,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStepItem("1", "Potentiometer von der Schaltung trennen"),
                      _buildStepItem("2", "3,3V an einen äußeren Pin, GND an den anderen anschließen"),
                      _buildStepItem("3", "Mittleren Pin (Schleifer) an Spannungseingang Ux anschließen"),
                      _buildStepItem("4", "Maximalen Widerstandswert (Rmax) in Ohm eingeben"),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Eingabefeld
            TextField(
              controller: _rMaxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Rmax Wert (Ohm)",
                labelStyle: TextStyle(
                  color: AppColors.primaryColor.withOpacity(0.4),
                  fontWeight: FontWeight.w100
                ),
                hintText: "z.B. 5000 für 5 kΩ",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    // Berechnung starten, wenn Wert eingegeben
                    final rMax = double.tryParse(_rMaxController.text);
                    if (rMax != null) {
                      calculateRxValue(rMax);
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onChanged: (value) {
                final rMax = double.tryParse(value);
                if (rMax != null) {
                  calculateRxValue(rMax);
                } else {
                  setState(() {
                    rxValue = null;
                  });
                }
              },
              onSubmitted: (value) {
                final rMax = double.tryParse(value);
                if (rMax != null) {
                  calculateRxValue(rMax);
                }
              },
            ),
            
            SizedBox(height: 16),
            
            // Ergebnis
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Aktueller Widerstand: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  Flexible(
                    child: Text(
                      isCalculating 
                        ? "Berechne..." 
                        : (isConnected ? (rxValue?.toStringAsFixed(2) ?? "-") + " Ω" : "Nicht verbunden"),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),

            // Bestätigen Button
            ElevatedButton(
              onPressed: () {
                final rMax = double.tryParse(_rMaxController.text);
                if (rMax != null) {
                  try {
                    if (rxValue != null) {
                      widget.onRMaxSubmitted(rMax, rxValue!);
                    } else if (widget.latestVoltage != null) {
                      // Calculate one last time before submitting
                      const double uMax = 3.3;
                      final calculatedRx = (widget.latestVoltage! / uMax) * rMax;
                      widget.onRMaxSubmitted(rMax, calculatedRx);
                    } else {
                      // No voltage data, still submit the rMax
                      widget.onRMaxSubmitted(rMax, 0);
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print("Error submitting rMax: $e");
                    }
                  }
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "Bestätigen",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hilfsmethode für Schrittdarstellung
  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    BLEManager().connectionStatus.removeListener(_onConnectionStatusChanged);
    _rMaxController.dispose();
    super.dispose();
  }
}
