import 'package:flutter/material.dart';

class WaveChat extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();

    // Path number 1

    paint.color = Colors.white;
    path = Path();
    path.lineTo(0, size.height * 0.03);
    path.cubicTo(
      0,
      size.height * 0.03,
      size.width * 0.34,
      -0.03,
      size.width * 0.54,
      size.height * 0.03,
    );
    path.cubicTo(
      size.width * 0.74,
      size.height * 0.09,
      size.width,
      size.height * 0.03,
      size.width,
      size.height * 0.03,
    );
    path.cubicTo(
      size.width,
      size.height * 0.03,
      size.width,
      size.height,
      size.width,
      size.height,
    );
    path.cubicTo(
      size.width,
      size.height,
      size.width * 0.72,
      size.height,
      size.width / 2,
      size.height,
    );
    path.cubicTo(
      size.width * 0.28,
      size.height,
      0,
      size.height,
      0,
      size.height,
    );
    path.cubicTo(0, size.height, 0, size.height * 0.03, 0, size.height * 0.03);
    path.cubicTo(
      0,
      size.height * 0.03,
      0,
      size.height * 0.03,
      0,
      size.height * 0.03,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
