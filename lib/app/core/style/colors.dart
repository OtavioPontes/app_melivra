import 'package:flutter/material.dart';

import 'i_colors.dart';

class ColorsMeLivra implements IColors {
  factory ColorsMeLivra() => _instance;
  ColorsMeLivra._();

  static final ColorsMeLivra _instance = ColorsMeLivra._();

  @override
  final MaterialColor black = const MaterialColor(
    0xFF272727,
    <int, Color>{
      50: Color(0xFFfbfbfb),
      100: Color(0xFFf6f6f6),
      200: Color(0xFFf1f1f1),
      300: Color(0xFFe7e7e7),
      400: Color(0xFFc4c4c4),
      500: Color(0xFFa6a6a6),
      600: Color(0xFF7c7c7c),
      700: Color(0xFF686868),
      800: Color(0xFF494949),
      900: Color(_blackPrimaryValue),
    },
  );
  static const int _blackPrimaryValue = 0xFF272727;

  @override
  final Color white = const Color(0xFFFAFAFA);

  @override
  final Color grey = const Color(0xFFB4B4B4);

  @override
  final Color purple = const Color(0xFF651B94);

  @override
  final MaterialColor green =
      const MaterialColor(_greenPrimaryValue, <int, Color>{
    50: Color(0xFFeaf9e6),
    100: Color(0xFFcbf0c0),
    200: Color(0xFFa8e696),
    300: Color(0xFF80db68),
    400: Color(0xFF5cd342),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF0dba00),
    700: Color(0xFF00a500),
    800: Color(0xFF009100),
    900: Color(0xFF006f00),
  });
  static const int _greenPrimaryValue = 0xFF2dca0a;

  @override
  final Color red = const Color(0xFFD32020);

  @override
  final Color yellow = const Color(0xFFEDD349);

  @override
  final Color blueGrey = const Color(0xFFA3B3C2);

  @override
  final Color lightPurple = const Color(0xFFE2CAFF);
}
