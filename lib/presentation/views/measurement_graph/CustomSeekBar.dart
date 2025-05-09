import 'dart:ui' as ui;
import 'package:infinity_circuit/exports.dart';

class CustomSeekBar extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSeekBar({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            thumbShape: CustomSliderThumbImage(
              thumbImage: AssetImage('assets/icons/ic_indicator.png'),
              height: SizeConfig.relativeHeight(2),
            ),
            trackHeight: 3.0,
            activeTrackColor: AppColors.colorD3,
            inactiveTrackColor: AppColors.colorD3,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: SizedBox(
            height: 12,
            width: double.infinity,
            child: Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.relativeHeight(1)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(10, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: CommonTextWidget(
                text: '${(index + 1)}',
                fontSize: SizeConfig.setSp(10),
                fontWeight: ui.FontWeight.bold,
                color: (index + 1).toDouble() == value
                    ? AppColors.primaryColor
                    : AppColors.colorCACACA,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class SliderWithBars extends StatefulWidget {
  const SliderWithBars({super.key});

  @override
  SliderWithBarsState createState() => SliderWithBarsState();
}

class SliderWithBarsState extends State<SliderWithBars> {
  double _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          CustomSeekBar(
            value: _currentValue,
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomSliderThumbImage extends SliderComponentShape {
  final ImageProvider thumbImage;
  final double height;
  final double width;

  CustomSliderThumbImage({
    required this.thumbImage,
    this.height = 28.0,
    this.width = 28.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, height);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final ImageStream imageStream = thumbImage.resolve(ImageConfiguration());
    final ImageStreamListener listener = ImageStreamListener(
          (ImageInfo imageInfo, bool synchronousCall) {
        final ui.Image image = imageInfo.image;
        final Offset imageOffset = Offset(
          center.dx - (width / 2),
          center.dy - (height / 2),
        );

        paintImage(
          canvas: canvas,
          image: image,
          rect: Rect.fromLTWH(imageOffset.dx, imageOffset.dy, width, height),
          fit: BoxFit.contain,
        );
      },
      onError: (error, stackTrace) {
        log('Error loading image: $error');
      },
    );

    imageStream.addListener(listener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      imageStream.removeListener(listener);
    });
  }
}
