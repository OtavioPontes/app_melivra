import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/core/style/fonts.dart';
import 'package:app_melivra/app/core/extensions/brightness_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemesMeLivra {
  ThemesMeLivra._();
  static ThemeData get light {
    return customTheme(
      brightness: Brightness.light,
      primary: ColorsMeLivra().purple,
      primaryVariant: ColorsMeLivra().lightPurple,
      onPrimary: ColorsMeLivra().white,
      secondary: ColorsMeLivra().green,
      secondaryVariant: ColorsMeLivra().green.shade800,
      onSecondary: ColorsMeLivra().white,
      background: ColorsMeLivra().white,
      scaffoldBackground: ColorsMeLivra().white,
      onBackground: ColorsMeLivra().black,
      surface: ColorsMeLivra().white,
      onSurface: ColorsMeLivra().black,
      error: ColorsMeLivra().red,
      onError: ColorsMeLivra().white,
      disabledColor: ColorsMeLivra().black.withOpacity(.38),
      dividerColor: ColorsMeLivra().grey,
      dialogBackgroundColor: ColorsMeLivra().white,
      bottomNavigationBarBackgroundColor: ColorsMeLivra().white,
      inputFillColor: ColorsMeLivra().black,
      appBarBackgroundColor: ColorsMeLivra().white,
      fontColor: ColorsMeLivra().black,
      primarySwatch: ColorsMeLivra().black,
    );
  }

  static ThemeData get dark {
    return customTheme(
      brightness: Brightness.dark,
      primary: ColorsMeLivra().purple,
      primaryVariant: ColorsMeLivra().purple,
      onPrimary: ColorsMeLivra().black,
      secondary: ColorsMeLivra().purple,
      secondaryVariant: ColorsMeLivra().purple,
      onSecondary: ColorsMeLivra().black,
      background: ColorsMeLivra().black,
      scaffoldBackground: ColorsMeLivra().black,
      onBackground: ColorsMeLivra().white,
      surface: ColorsMeLivra().black.shade800,
      onSurface: ColorsMeLivra().white,
      error: ColorsMeLivra().red,
      onError: ColorsMeLivra().black,
      disabledColor: ColorsMeLivra().white.withOpacity(.12),
      dividerColor: ColorsMeLivra().white.withOpacity(.32),
      dialogBackgroundColor: ColorsMeLivra().black.shade50,
      bottomNavigationBarBackgroundColor: ColorsMeLivra().black.shade300,
      inputFillColor: ColorsMeLivra().black.shade300,
      appBarBackgroundColor: ColorsMeLivra().black.shade500,
      fontColor: ColorsMeLivra().white,
      primarySwatch: ColorsMeLivra().black,
    );
  }

  /// ## customTheme
  ///
  /// [brightness] :
  /// ### Primary
  /// [primary] : The color displayed most frequently across your app’s screens and components.
  ///
  /// [primaryVariant] : A darker version of the primary color.
  ///
  /// [onPrimary] : A color that's clearly legible when drawn on [primary].
  ///
  /// ### Secondary
  /// [secondary] : An accent color that, when used sparingly, calls attention to parts of your app.
  ///
  /// [secondaryVariant] : A darker version of the secondary color.
  ///
  /// [onSecondary] : A color that's clearly legible when drawn on [secondary].
  ///
  /// ### Background
  /// [scaffoldBackground] : A color that appears behind [surface] content (light = white : dark = black).
  ///
  /// [background] : A color that typically appears behind scrollable content (light = blue light : dark = black).
  ///
  /// [onBackground] : A color that's clearly legible when drawn on [background] and [scaffoldBackground].
  ///
  /// ### Surface
  /// [surface] : The background color for widgets like [Card].
  ///
  /// [onSurface] : A color that's clearly legible when drawn on [surface]
  ///
  /// ### Error
  /// [error] : The color to use for input validation errors, e.g. for [InputDecoration.errorText].
  ///
  /// [onError] : A color that's clearly legible when drawn on [error].
  ///
  /// ### Misc
  /// [disabledColor] : A color that appears in disabled components.
  ///
  /// [dividerColor] : A color that appears in strokes and borders to divide content.
  ///
  /// [inputFillColor] : Default color for the fillColor property for textFormFieldWay.
  ///
  /// ### Primary Swatch
  /// [primarySwatch]
  static ThemeData customTheme({
    required Brightness brightness,
    // Primary
    required Color primary,
    required Color primaryVariant,
    required Color onPrimary,
    // Secondary
    required Color secondary,
    required Color secondaryVariant,
    required Color onSecondary,
    // Background
    required Color background,
    required Color scaffoldBackground,
    required Color onBackground,
    // Surface
    required Color surface,
    required Color onSurface,
    // Error
    required Color error,
    required Color onError,
    // Misc
    required Color disabledColor,
    required Color dividerColor,
    required Color dialogBackgroundColor,
    required Color bottomNavigationBarBackgroundColor,
    required Color appBarBackgroundColor,
    required Color inputFillColor,
    required Color fontColor,
    required MaterialColor primarySwatch,
  }) {
    return ThemeData(
      brightness: brightness,
      primarySwatch: primarySwatch,
      primaryColor: primary,
      primaryColorLight:
          brightness.isLight ? primarySwatch.shade50 : primarySwatch.shade900,
      primaryColorDark: primaryVariant,
      backgroundColor: background,
      scaffoldBackgroundColor: scaffoldBackground,
      cardColor: surface,
      disabledColor: disabledColor,
      dividerColor: dividerColor,
      dialogBackgroundColor: dialogBackgroundColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        secondary: secondary,
        background: background,
        surface: surface,
        error: error,
        primaryVariant: primaryVariant,
        secondaryVariant: secondaryVariant,
        onBackground: onBackground,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onError: onError,
        onSurface: onSurface,
      ),
      fontFamily: FontsMeLivra.quicksand,
      primaryTextTheme: const TextTheme(),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 83.scale,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        headline2: TextStyle(
          fontSize: 52.scale,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        headline3: TextStyle(
          fontSize: 42.scale,
          fontWeight: FontWeight.w400,
        ),
        headline4: TextStyle(
          fontSize: 29.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headline5: TextStyle(
          fontSize: 21.scale,
          fontWeight: FontWeight.w400,
        ),
        headline6: TextStyle(
          fontSize: 17.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        subtitle1: TextStyle(
          fontSize: 14.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        subtitle2: TextStyle(
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyText1: TextStyle(
          fontSize: 14.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyText2: TextStyle(
          fontSize: 12.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        button: TextStyle(
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        caption: TextStyle(
          fontSize: 10.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        overline: TextStyle(
          fontSize: 9.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        focusColor: primary,
        fillColor: inputFillColor,
        border: InputBorder.none,
        errorStyle: TextStyle(
          color: error,
        ),
        labelStyle: TextStyle(
          color: fontColor.withOpacity(.87),
          fontSize: 16.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: primary,
        backgroundColor: bottomNavigationBarBackgroundColor,
        unselectedItemColor: disabledColor,
        selectedLabelStyle: TextStyle(
          fontFamily: FontsMeLivra.quicksand,
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          color: primary,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: FontsMeLivra.quicksand,
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          color: disabledColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        disabledColor: disabledColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        foregroundColor: primary,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontSize: 20.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: primary,
          fontFamily: FontsMeLivra.quicksand,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: appBarBackgroundColor,
          statusBarIconBrightness: brightness.opposite,
          statusBarBrightness: brightness,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(onPrimary),
        fillColor: MaterialStateProperty.all<Color>(primary),
      ),
      iconTheme: IconThemeData(
        color: primary,
        size: 24.scale,
      ),
      primaryIconTheme: IconThemeData(
        color: primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(secondary),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        elevation: brightness.isLight ? 4.0 : 0.0,
        shadowColor: primary.withOpacity(.2),
        color: surface,
        margin: EdgeInsets.zero,
      ),
    );
  }
}
