import '../../exports.dart';

class GradientTextWidget extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? style;
  final TextAlign textAlign;

  const GradientTextWidget({
    super.key,
    required this.text,
    required this.gradient,
    this.style,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: style ?? const TextStyle(color: AppColors.white),
      ),
    );
  }
}
