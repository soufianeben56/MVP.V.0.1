import 'package:infinity_circuit/exports.dart';

class CommonAppButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final BoxDecoration? boxDecoration;
  final bool isNormalText;
  final Color? backGroundColor;
  final Color? normalTextColor;
  final double? normalFontSize;
  final double? height;
  final double? radius;
  final FontWeight? fontWeight;
  final String? svgAsset;
  final EdgeInsetsGeometry? padding;

  const CommonAppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.boxDecoration,
    this.isNormalText = true,
    this.backGroundColor = AppColors.primaryColor,
    this.normalTextColor = AppColors.white,
    this.normalFontSize,
    this.height,
    this.radius,
    this.fontWeight = FontWeight.w500,
    this.svgAsset,
    required width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: boxDecoration ??
            BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.circular(radius ?? 45),
            ),
        padding: padding ??
            EdgeInsets.symmetric(vertical: SizeConfig.relativeHeight(1.5)),
        alignment: Alignment.center,
        child: svgAsset != null
            ? SvgPicture.asset(
                svgAsset!,
                width: 24, // Adjust the width as needed
                height: 24, // Adjust the height as needed
                color: normalTextColor, // Apply color if necessary
              )
            : isNormalText
                ? CommonTextWidget(
                    text: title,
                    color: normalTextColor,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontFamily: "Poppins-Regular",
                    fontSize: normalFontSize ?? SizeConfig.setSp(14),
                  )
                : GradientTextWidget(
                    text: title,
                    style: TextStyle(
                      fontSize: SizeConfig.setSp(18),
                      color: AppColors.white,
                      fontWeight: fontWeight,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.linearColor1,
                        AppColors.linearColor2,
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
      ),
    );
  }
}
