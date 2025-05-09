import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../../../generated/assets.gen.dart';
import '../measurement_graph/solution_appbar.dart';
import 'blue_manager.dart';
import 'package:infinity_circuit/exports.dart';
import 'package:intl/intl.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  ScanningScreenState createState() => ScanningScreenState();
}

class ScanningScreenState extends State<ScanningScreen> {
  List<BluetoothDevice> devicesList = [];
  bool isScanning = false;
  BluetoothDevice? deviceBeingConnected;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  Timer? _timer;
  Timer? _statusTimer;
  String _connectingText = "Connecting";
  bool _hasShownSnackbar = false;

  @override
  void initState() {
    super.initState();
    _initializeScanning();
    _startConnectingAnimation();
    _startConnectionStatusCheck();
  }

  Future<void> _initializeScanning() async {
    await startScan();
  }

  void _startConnectingAnimation() {
    int dotCount = 1;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          dotCount = (dotCount + 1) % 4;
          _connectingText = "Connecting${'.' * dotCount}";
        });
      }
    });
  }

  String _getCurrentTimestamp() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  void _startConnectionStatusCheck() {
    _statusTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (mounted) {
        if (BLEManager().connectedDevice != null) {
          if (kDebugMode) {
            print("${_getCurrentTimestamp()} - ${BLEManager().connectedDevice!.platformName} is connected.");
          }
        } else {
          if (kDebugMode) {
            print("${_getCurrentTimestamp()} - No device is connected.");
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _statusTimer?.cancel();
    _connectionSubscription?.cancel();
    super.dispose();
  }

  Future<void> startScan() async {
    if (!isScanning) {
      setState(() {
        isScanning = true;
        devicesList.clear();
      });

      if (BLEManager().connectedDevice != null) {
        devicesList.add(BLEManager().connectedDevice!);
      }

      FlutterBluePlus.scanResults.listen((results) {
        if (mounted) {
          for (ScanResult result in results) {
            if (result.device.platformName.isNotEmpty &&
                !devicesList.any((d) => d.remoteId == result.device.remoteId)) {
              setState(() {
                devicesList.add(result.device);
              });
            }
          }
        }
      });

      await FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

      if (mounted) {
        setState(() {
          isScanning = false;
        });
      }
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (BLEManager().connectedDevice != null) {
      await disconnectFromDevice(BLEManager().connectedDevice!);
    }

    if (mounted) {
      setState(() {
        deviceBeingConnected = device;
      });
    }

    try {
      await BLEManager().connectToDevice(device);
      _connectionSubscription = device.connectionState.listen((BluetoothConnectionState state) async {
        if (mounted) {
          if (state == BluetoothConnectionState.connected) {
            if (kDebugMode) {
              print("${_getCurrentTimestamp()} - ${device.platformName} is really connected.");
            }
            setState(() {
              deviceBeingConnected = null;
              _hasShownSnackbar = false;
            });
          } else if (state == BluetoothConnectionState.disconnected) {
            if (kDebugMode) {
              print("${_getCurrentTimestamp()} - ${device.platformName} is disconnected.");
            }
            if (!_hasShownSnackbar) {
              _showDisconnectionSnackbars(device.platformName);
              _hasShownSnackbar = true;
            }
            setState(() {
              BLEManager().connectedDevice = null;
            });
          }
        }
      });

      Timer(Duration(minutes: 1), () async {
        if (mounted && deviceBeingConnected != null) {
          _showTimeoutSnackBar(device.platformName);
          await disconnectFromDevice(device);
          setState(() {
            deviceBeingConnected = null;
          });
        }
      });
    } catch (e) {
      _showErrorSnackBar(device.platformName, e.toString());
      setState(() {
        deviceBeingConnected = null;
      });
    }
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await BLEManager().disconnectFromDevice();
    _connectionSubscription?.cancel();
    if (mounted) {
      setState(() {
        BLEManager().connectedDevice = null;
      });
    }
  }

  void _showDisconnectionSnackbars(String deviceName) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$deviceName disconnected. (1/2)'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$deviceName disconnected. (2/2)'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  void _showTimeoutSnackBar(String deviceName) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection to $deviceName timed out.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showErrorSnackBar(String deviceName, String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error connecting to $deviceName: $error'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget buildDeviceList() {
    return ListView.separated(
      itemCount: devicesList.length + 2,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Divider(color: Colors.grey.withOpacity(0.4), height: 1),
      ),
      itemBuilder: (context, index) {
        if (index == 0 || index == devicesList.length + 1) {
          return SizedBox.shrink();
        }

        BluetoothDevice device = devicesList[index - 1];
        bool isConnected = device == BLEManager().connectedDevice;
        bool isConnecting = device == deviceBeingConnected;

        return Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: ListTile(
            title: Text(
              device.platformName.length > 30 ? '${device.platformName.substring(0, 20)}...' : device.platformName,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              isConnected ? "Connected" : (isConnecting ? _connectingText : "Not connected"),
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            trailing: isConnected
                ? GestureDetector(
              onTap: () => disconnectFromDevice(device),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Assets.svg.icBlueOn.svg(
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            )
                : isConnecting
                ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green))
                : GestureDetector(
              onTap: () => connectToDevice(device),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Assets.svg.icBlueOff.svg(
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorF4F4F4,
      appBar: SolutionAppBar(
        title: 'Gerätescan',
        backgroundColor: Colors.transparent,
        actionIcon: Assets.svg.icRefresh,
        onTapAction: () {
          startScan();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buildDeviceList()),
          ],
        ),
      ),
    );
  }
}
