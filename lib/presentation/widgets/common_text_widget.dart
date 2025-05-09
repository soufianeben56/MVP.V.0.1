import 'package:infinity_circuit/exports.dart';

class CommonTextWidget extends StatelessWidget {
  final String? text;
  final List<TextSpan>? children;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow overflow; // Make this non-nullable
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDirection? textDirection;
  final double? fontHeight;
  final TextDecoration? decoration;

  const CommonTextWidget({
    super.key,
    this.text,
    this.children,
    this.color,
    this.fontFamily,
    this.fontSize = 14,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.textStyle,
    this.textDirection,
    this.fontHeight,
    this.decoration,
    this.overflow = TextOverflow.clip, // Provide a default value for overflow
  }) : assert(text != null || children != null, 'Either text or children must be provided.');

  @override
  Widget build(BuildContext context) {
    if (children != null) {
      // Use RichText when children are provided
      return RichText(
        textDirection: textDirection,
        text: TextSpan(
          style: textStyle ??
              TextStyle(
                color: color ?? AppColors.primaryColor,
                fontFamily: fontFamily ?? GoogleFonts.poppins().fontFamily,
                fontSize: SizeConfig.setSp(fontSize!).toDouble(),
                fontStyle: fontStyle,
                fontWeight: fontWeight ?? FontWeight.normal,
                height: fontHeight,
                decoration: decoration,
              ),
          children: children,
        ),
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        overflow: overflow, // Use the non-nullable overflow value here
      );
    }

    // Default to single Text widget when no children are provided
    return Text(
      text!,
      textDirection: textDirection,
      style: textStyle ??
          TextStyle(
            color: color ?? AppColors.primaryColor,
            fontFamily: fontFamily ?? GoogleFonts.poppins().fontFamily,
            fontSize: SizeConfig.setSp(fontSize!).toDouble(),
            fontStyle: fontStyle,
            fontWeight: fontWeight ?? FontWeight.normal,
            height: fontHeight,
            decoration: decoration,
          ),
      textAlign: textAlign,
      overflow: overflow, // Use the non-nullable overflow value here
      maxLines: maxLines,
    );
  }
}
