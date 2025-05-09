import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/presentation/views/register/register_viewmodel.dart';
import '../../../generated/assets.gen.dart';
import '../../../generated/l10n.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.colorF4F4F4,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: SizeConfig.relativeHeight(3.18),
                          width: SizeConfig.relativeWidth(27.60),
                        ),
                        Assets.icons.imgSplashLogo.image(
                          height: SizeConfig.relativeHeight(20.28),
                          width: SizeConfig.relativeWidth(30.47),
                        ),
                        SizedBox(
                          height: SizeConfig.relativeHeight(3.33),
                          width: SizeConfig.relativeWidth(13.07),
                        ),
                        CommonTextWidget(
                          text: S.current.anmeldung,
                          fontSize: SizeConfig.setSp(16),
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.relativeHeight(1.0)),
                        Divider(
                          color: AppColors.grey,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: SizeConfig.relativeHeight(2.13),
                          width: SizeConfig.screenWidth,
                        ),
                        CommonTextWidget(
                          text: S.current.name,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.left,
                          color: AppColors.black,
                          fontSize: SizeConfig.setSp(12),
                        ),
                        SizedBox(height: SizeConfig.relativeHeight(1.0)),
                        CommonTextFiled(
                          controller: viewModel.nameController,
                          onChanged: (String) {},
                          onEditingComplete: () {},
                          onSubmitted: (string) {
                            FocusScope.of(context).nextFocus();
                          },
                          textInputAction: TextInputAction.next,
                          hintText: 'Geben Sie den Namen ein',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CommonTextWidget(
                            text: S.current.email,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.left,
                            color: AppColors.black,
                            fontSize: SizeConfig.setSp(12),
                          ),
                        ),
                        SizedBox(height: SizeConfig.relativeHeight(1.0)),
                        CommonTextFiled(
                          controller: viewModel.emailController,
                          maxLines: 1,
                          onChanged: (string) {},
                          onEditingComplete: () {},
                          onSubmitted: (string) {
                            FocusScope.of(context).nextFocus();
                          },
                          hintText: 'Geben Sie die E-Mail-Adresse ein',
                          textInputAction: TextInputAction.next,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CommonTextWidget(
                            text: S.current.password,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.left,
                            color: AppColors.black,
                            fontSize: SizeConfig.setSp(12),
                          ),
                        ),
                        SizedBox(height: SizeConfig.relativeHeight(1.0)),
                        CommonTextFiled(
                          controller: viewModel.passwordController,
                          obscureText: !viewModel.isPassVisibility,
                          maxLines: 1,
                          onChanged: (string) {},
                          onEditingComplete: () {},
                          onSubmitted: (string) {
                            FocusScope.of(context).unfocus();
                          },
                          textInputAction: TextInputAction.done,
                          hintText: 'Passwort eingeben',
                          isSuffix: true,
                          visibilityTap: viewModel.togglePasswordVisibility,
                          isPassVisibility: viewModel.isPassVisibility,
                        ),
                        SizedBox(height: SizeConfig.relativeHeight(4.0)),
                        CommonAppButton(
                          onTap: () {
                            viewModel.register(context);
                          },
                          title: 'Registrieren',
                          width: null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget(
                                text: S.current.alreadyHaveAccount,
                                fontSize: SizeConfig.setSp(12),
                                color: AppColors.black,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: InkWell(
                                  onTap: () {
                                    viewModel.onTapLog();
                                  },
                                  child: CommonTextWidget(
                                    text: S.current.login,
                                    fontSize: SizeConfig.setSp(12),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget(
                                text: S.current.byContinuing,
                                fontSize: SizeConfig.setSp(11),
                                color: AppColors.black,
                                textAlign: TextAlign.center,
                              ),
                              CommonTextWidget(
                                text: S.current.terms_and_condition,
                                fontSize: SizeConfig.setSp(11),
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                textAlign: TextAlign.center,
                                decoration: TextDecoration.underline,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.relativeHeight(2.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
