import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'logout_viewmodel.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogoutViewModel>.reactive(
      viewModelBuilder: () => LogoutViewModel(),
      builder: (context, model, child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20.0), // Adjust the border radius as needed
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  20.0), // Adjust the border radius as needed
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.relativeWidth(0.87)),
                    child: GestureDetector(
                      onTap: () => model.onTapBack(),
                      child: Assets.svg.icCrossCircle1Svg.svg(
                        width: SizeConfig.relativeWidth(5.00),
                        height: SizeConfig.relativeHeight(2.85),
                      ),
                    ),
                  ),
                ),
                Assets.svg.icLog.svg(
                    height: SizeConfig.relativeHeight(12.09),
                    width: SizeConfig.relativeWidth(12.59)),
                SizedBox(height: SizeConfig.relativeHeight(2.80)),
                CommonTextWidget(
                  text: strAbmelden,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  fontSize: 20,
                ),
                SizedBox(height: SizeConfig.relativeHeight(1.00)),
                CommonTextWidget(
                  text: strAbmelden1,
                  color: AppColors.color212121.withOpacity(0.60),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.relativeHeight(4.00)),
                CommonAppButton(
                  onTap: () => model.onTapLogout(),
                  title: 'Abmelden',
                  width: null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
