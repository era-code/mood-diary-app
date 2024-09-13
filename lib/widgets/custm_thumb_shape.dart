import 'package:flutter/material.dart';

class CustomThumbShape extends RoundSliderThumbShape {
  final double enabledThumbRadius;
  final double borderWidth;
  final Color borderColor;

  const CustomThumbShape({
    required this.enabledThumbRadius,
    this.borderWidth = 9.0,
    this.borderColor = Colors.white, 
  }) : super(enabledThumbRadius: enabledThumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    TextPainter? labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.orange
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, enabledThumbRadius, paint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
}

class SliderWithCustomThumb extends StatefulWidget {
  @override
  _SliderWithCustomThumbState createState() => _SliderWithCustomThumbState();
}

class _SliderWithCustomThumbState extends State<SliderWithCustomThumb> {
  double _currentValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.orange,
        inactiveTrackColor: Colors.grey,
        
        overlayColor: Colors.orange.withOpacity(0.2),
        trackHeight: 4.0,
        overlayShape: SliderComponentShape.noOverlay,
        thumbShape: const CustomThumbShape(
          enabledThumbRadius: 10.0,
          borderWidth: 5.0,
          borderColor: Colors.white, 
        ),
      ),
      child: Slider(
        value: _currentValue,
        min: 0.0,
        max: 6.0,
        label: _currentValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentValue = value;
          });
        },
      ),
    );
  }
}
