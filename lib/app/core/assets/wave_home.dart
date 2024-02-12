import 'package:flutter/material.dart';

class WaveHome extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();

    // Path number 1

    final gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(40, 164, 80, 216),
        Color(0xff651B94),
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    paint.shader = gradient;
    path = Path();
    path.lineTo(0, size.height * 0.03);
    path.cubicTo(
      0,
      size.height * 0.03,
      size.width * 0.35,
      -0.03,
      size.width * 0.6,
      size.height * 0.03,
    );
    path.cubicTo(
      size.width * 0.84,
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
