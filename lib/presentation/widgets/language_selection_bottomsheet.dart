import '../../exports.dart';
import '../../generated/l10n.dart';

class LanguageSelectionBottomSheet extends StatelessWidget {
  final Function() onTapDown;
  final Function(String langCode) onTapLanguage;

  const LanguageSelectionBottomSheet({
    super.key,
    required this.onTapDown,
    required this.onTapLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SizeConfig.relativeWidth(100),
          padding: EdgeInsets.only(
            top: SizeConfig.relativeHeight(2.83),
            bottom: SizeConfig.relativeHeight(2.46),
            right: SizeConfig.relativeWidth(6.67),
            left: SizeConfig.relativeWidth(6.67),
          ),
          child: Stack(
            children: [
              Positioned(
                left: UserPreference.getString(PrefKeys.languageCode) ==
                        LocalisationNotifier.german
                    ? 0
                    : null,
                right: UserPreference.getString(PrefKeys.languageCode) ==
                        LocalisationNotifier.german
                    ? null
                    : 0,
                child: SizedBox(
                  // color: Colors.red,
                  height: SizeConfig.relativeHeight(2.46),
                  width: SizeConfig.relativeHeight(2.46),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 24,
                  ).addGestureTap(onTap: onTapDown),
                ),
              ),
              SizeConfig.horizontalSpacer(19.20),
              CommonTextWidget(
                text: S.current.german,
                color: AppColors.black,
                fontSize: 18,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ).wrapCenter()
            ],
          ),
        ),
        ...LocalisationNotifier.supportedLocales(context).map(
          (e) => LanguageCodeWidget(
            label: e.label!,
            flag: e.flag!,
            code: e.code!,
          ).addGestureTap(onTap: () {
            onTapLanguage(e.code!);
          }),
        )
      ],
    );
  }
}

class LanguageCodeWidget extends StatelessWidget {
  final String label;
  final String code;
  final Widget flag;

  const LanguageCodeWidget({
    super.key,
    required this.label,
    required this.flag,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.relativeWidth(6.67),
            vertical: SizeConfig.relativeHeight(2.83),
          ),
          child: Row(
            children: [
              flag,
              SizeConfig.horizontalSpacer(4.54),
              CommonTextWidget(
                text: label,
                color: AppColors.black,
                fontSize: 15,
              ),
              const Spacer(),
              Container(
                height: SizeConfig.relativeHeight(2.22),
                width: SizeConfig.relativeHeight(2.22),
                padding: EdgeInsets.all(SizeConfig.relativeSize(1)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        UserPreference.getString(PrefKeys.languageCode) == code
                            ? AppColors.primaryColor
                            : Colors.grey,
                  ),
                ),
                child: UserPreference.getString(PrefKeys.languageCode) == code
                    ? Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(6.67)),
          child: const Divider(
            height: 0,
          ),
        )
      ],
    );
  }
}
