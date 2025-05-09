import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/presentation/views/scandevice/scandevice_viewmodel.dart';
import 'package:lottie/lottie.dart';
import '../../../generated/assets.gen.dart';
import 'bluetooth_disabled_widget.dart';

class ScanDeviceView extends StatelessWidget {
  const ScanDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanDeviceViewModel>.reactive(
      viewModelBuilder: () => ScanDeviceViewModel(),
      onViewModelReady: (viewModel) => viewModel.onInit(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.colorF4F4F4,
        appBar: CustomAppBar(
          title: 'Gerätescan',
          showAction: false,
          onTapLeading: () {},
        ),
        body: StreamBuilder(
          stream: FlutterBluePlus.adapterState,
          builder: (BuildContext context,
              AsyncSnapshot<BluetoothAdapterState> snapshot) {
            if (snapshot.data == BluetoothAdapterState.on) {
              return Center(
                child: Lottie.asset(
                  Assets.lotties.bluetoothJson
                      .path, // Use the path to your Lottie JSON file
                  height: SizeConfig.relativeHeight(16.87),
                  width: SizeConfig.relativeHeight(36.53),
                  fit: BoxFit.contain,
                ),
              );
            } else {
              return BluetoothDisabledWidget(
                onTapAllow: () => model.startBluetoothOperations(),
              );
            }
          },
        ),
      ),
    );
  }
}
