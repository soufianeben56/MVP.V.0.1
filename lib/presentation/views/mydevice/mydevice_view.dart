import 'package:infinity_circuit/exports.dart';

import '../../../generated/assets.gen.dart';
import 'mydevice_viewmodel.dart';

class MyDeviceView extends StatelessWidget {
  const MyDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyDeviceViewModel>.reactive(
      viewModelBuilder: () => MyDeviceViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: CustomAppBar(
            title: 'Mein Gerät',
            showAction: false,
            showLeading: true,
            //onTapLeading: ()=>viewModel.back(),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Center(
                  child: Assets.icons.icMydevice.image(
                    height: SizeConfig.relativeHeight(25.55),
                    width: SizeConfig.relativeHeight(33.55),
                  ),
                ),
                SizedBox(height: SizeConfig.relativeHeight(3)),
                /*CommonTextWidget(
                  text:
                      'There is no connected device.\nPlease press "add device" button to add with your device.',
                  fontSize: SizeConfig.setSp(12),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  color: AppColors.color212121.withOpacity(0.6),
                  fontHeight: 1.8,
                ).*/
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'There is no connected device.\nPlease press ',
                    style: TextStyle(
                      fontSize: SizeConfig.setSp(12),
                      fontWeight: FontWeight.w400,
                      color: AppColors.color212121.withOpacity(0.6),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      height: 1.8,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '"add device" ',
                        style: TextStyle(
                          fontSize: SizeConfig.setSp(12),
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: AppColors.color212121.withOpacity(0.6),
                          height: 1.8,
                        ),
                      ),
                      TextSpan(
                        text: 'button to add with your device. ',
                        style: TextStyle(
                          fontSize: SizeConfig.setSp(12),
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: AppColors.color212121.withOpacity(0.6),
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ).wrapPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.relativeWidth(12.27))),
                Spacer(),
                SizedBox(
                  height: SizeConfig.relativeHeight(5.54),
                  width: SizeConfig.relativeWidth(40.07),
                ),
                CommonAppButton(
                  onTap: () {
                    viewModel.onTapScan();
                  },
                  title: 'Gerät hinzufügen',
                  width: null,
                ).wrapPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 37,
                        vertical: SizeConfig.relativeHeight(5))),
              ],
            ),
          ),
        );
      },
    );
  }
}
