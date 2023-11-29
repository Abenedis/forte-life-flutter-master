import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  const CustomSliderThumbCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
    this.valueMapper,
    this.width = 60,
  });

  final double thumbRadius;
  final int min;
  final int max;
  final int width;
  final String Function(double) valueMapper;
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint rectPaint = Paint()
      ..color = StandardColors.primaryColor
      ..style = PaintingStyle.fill;

    final TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white, //Text Color of Value on Thumb
      ),
      text: valueMapper != null
          ? valueMapper(getDoubleValue(value))
          : getValue(value),
    );

    final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    final Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy),
          height: 40,
          width: width.toDouble(),
        ),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      rectPaint,
    );
    tp.paint(canvas, textCenter);
  }

  double getDoubleValue(double value) => min + (max - min) * value;

  String getValue(double value) => getDoubleValue(value).round().toString();
}
