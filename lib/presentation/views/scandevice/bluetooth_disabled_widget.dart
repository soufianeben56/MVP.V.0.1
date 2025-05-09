import 'package:infinity_circuit/exports.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.gen.dart';

class BluetoothDisabledWidget extends StatelessWidget {
  final Function() onTapAllow;

  const BluetoothDisabledWidget({
    super.key,
    required this.onTapAllow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizeConfig.verticalSpacer(8),

        /// bluetooth scan animation
        Center(
          child: Lottie.asset(
            Assets.lotties.bluetoothJson
                .path, // Use the path to your Lottie JSON file
            height: SizeConfig.relativeHeight(16.87),
            width: SizeConfig.relativeHeight(36.53),
            fit: BoxFit.contain,
          ),
        ),
        SizeConfig.verticalSpacer(8),

        /// Disable Bluetooth Text
        CommonTextWidget(
          text: "Kindly Turn On Bluetooth",
          fontSize: SizeConfig.setSp(15),
          textAlign: TextAlign.center,
        ),
        SizeConfig.verticalSpacer(4),
        CommonAppButton(
          title: "Allow Bluetooth Permission",
          onTap: onTapAllow,
          width: null,
        )
            .visibility(Platform.isAndroid)
            .wrapPadding(padding: EdgeInsets.symmetric(horizontal: 45))
      ],
    );
  }
}
