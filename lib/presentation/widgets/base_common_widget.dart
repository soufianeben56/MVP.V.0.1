import '../../exports.dart';

mixin class BaseCommonWidget {
  getDynamicFontStyle({
    FontStyle? fontStyle,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontStyle: fontStyle ?? FontStyle.normal,
      fontSize: fontSize ?? 13,
      color: AppColors.background,
    );
  }

  void changeLanguage(
    BuildContext context, {
    required Function(String langCode) onTap,
    required Function() onTapBack,
  }) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      builder: (ctx) {
        return LanguageSelectionBottomSheet(
          onTapDown: onTapBack,
          onTapLanguage: onTap,
        );
      },
    );
  }
}
