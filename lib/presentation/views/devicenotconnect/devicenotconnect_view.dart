import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';

import 'devicenotconnect_viewmodel.dart';

class DevicenotConnectView extends StatelessWidget {
  const DevicenotConnectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DevicenotConnectViewModel>.reactive(
      viewModelBuilder: () => DevicenotConnectViewModel(),
      builder: (context, model, child) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            SizeConfig.relativeWidth(0.87)), // Optional padding
                    child: GestureDetector(
                      onTap: () {
                        // Close the dialog on tap
                        Navigator.of(context).pop();
                      },
                      child: Assets.svg.icCrossCircle1Svg.svg(
                        width: SizeConfig.relativeWidth(1.85),
                        height: SizeConfig.relativeHeight(4.00),
                      ),
                    ),
                  ),
                ),
                Assets.svg.icImage111.svg(
                    height: SizeConfig.relativeHeight(8.37),
                    width: SizeConfig.relativeWidth(18.13)),
                SizedBox(height: SizeConfig.relativeHeight(1)),
                CommonTextWidget(
                  text: strEntschuldigung,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  fontSize: 22,
                ),
                SizedBox(height: SizeConfig.relativeHeight(1)),
                CommonTextWidget(
                    text: strEntschuldigung1,
                    fontWeight: FontWeight.w500,
                    color: AppColors.color212121.withOpacity(0.60),
                    textAlign: TextAlign.center,
                    fontSize: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
