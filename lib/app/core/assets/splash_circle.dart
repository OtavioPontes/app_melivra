import 'package:flutter/material.dart';

class SplashCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();

    // Path number 1

    paint.color = const Color(0xff651B94);
    path = Path();
    path.lineTo(size.width, size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height, 0, size.height);
    path.cubicTo(
      0,
      size.height * 0.45,
      size.width * 0.43,
      0,
      size.width * 0.96,
      0,
    );
    path.cubicTo(size.width * 0.96, 0, size.width, 0, size.width, 0);
    path.cubicTo(
      size.width,
      0,
      size.width,
      size.height,
      size.width,
      size.height,
    );
    path.cubicTo(
      size.width,
      size.height,
      size.width,
      size.height,
      size.width,
      size.height,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
