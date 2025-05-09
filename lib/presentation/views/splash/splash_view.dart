import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/presentation/views/splash/splash_viewmodel.dart';

import '../../../generated/assets.gen.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),                    
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF8F8F8,
          body: CentralLoader(
            centralViewState: model.viewState,
            baseChild: _getBody(context, model),
          ),
        );
      },
      onViewModelReady: (viewModel) => viewModel.onInit(),
    );
  }

  Widget _getBody(BuildContext context, SplashViewModel model) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.icons.imgSplashLogo.image(
            height: SizeConfig.relativeHeight(25.49),
            width: SizeConfig.relativeHeight(49.33),
          ),
        ],
      ),
    );
  }
}
