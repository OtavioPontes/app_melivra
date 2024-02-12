import 'package:flutter/material.dart';

class WaveLogin extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();

    // Path number 1

    paint.color = const Color(0xff651B94);
    path = Path();
    path.lineTo(0, size.height * 0.13);
    path.cubicTo(
      0,
      size.height * 0.13,
      size.width * 0.22,
      -0.03,
      size.width * 0.51,
      size.height * 0.03,
    );
    path.cubicTo(
      size.width * 0.79,
      size.height * 0.08,
      size.width * 0.97,
      0,
      size.width,
      0,
    );
    path.cubicTo(
      size.width,
      0,
      size.width,
      size.height,
      size.width,
      size.height,
    );
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height * 0.13, 0, size.height * 0.13);
    path.cubicTo(
      0,
      size.height * 0.13,
      0,
      size.height * 0.13,
      0,
      size.height * 0.13,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
