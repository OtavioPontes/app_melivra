import 'package:app_melivra/app/core/extensions/brightness_extension.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/core/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorsMeLivra().purple,
      disabledColor: ColorsMeLivra().black.withOpacity(.38),
      dividerColor: ColorsMeLivra().black.withOpacity(.32),
      dialogBackgroundColor: ColorsMeLivra().black.shade50,
      primarySwatch: ColorsMeLivra().black,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorsMeLivra().purple,
        primaryContainer: ColorsMeLivra().purple,
        onPrimary: ColorsMeLivra().black,
        secondary: ColorsMeLivra().purple,
        secondaryContainer: ColorsMeLivra().purple,
        onSecondary: ColorsMeLivra().black,
        background: ColorsMeLivra().white,
        onBackground: ColorsMeLivra().white,
        surface: ColorsMeLivra().black.shade800,
        onSurface: ColorsMeLivra().white,
        error: ColorsMeLivra().red,
        onError: ColorsMeLivra().black,
      ),
      fontFamily: FontsMeLivra.quicksand,
      primaryTextTheme: const TextTheme(),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 83.scale,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 52.scale,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 42.scale,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          fontSize: 29.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headlineSmall: TextStyle(
          fontSize: 21.scale,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontSize: 17.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleMedium: TextStyle(
          fontSize: 14.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 14.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 12.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        labelLarge: TextStyle(
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        bodySmall: TextStyle(
          fontSize: 10.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        labelSmall: TextStyle(
          fontSize: 9.scale,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        focusColor: ColorsMeLivra().purple,
        fillColor: ColorsMeLivra().black,
        hintStyle: TextStyle(
          color: ColorsMeLivra().black.withOpacity(.38),
        ),
        border: InputBorder.none,
        errorStyle: TextStyle(
          color: ColorsMeLivra().red,
        ),
        labelStyle: TextStyle(
          color: ColorsMeLivra().black.withOpacity(.87),
          fontSize: 16.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: ColorsMeLivra().purple,
        backgroundColor: ColorsMeLivra().white,
        unselectedItemColor: ColorsMeLivra().black.withOpacity(.38),
        unselectedIconTheme: IconThemeData(
          color: ColorsMeLivra().black.withOpacity(.38),
        ),
        selectedLabelStyle: TextStyle(
          fontFamily: FontsMeLivra.quicksand,
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          color: ColorsMeLivra().purple,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: FontsMeLivra.quicksand,
          fontSize: 12.scale,
          fontWeight: FontWeight.w500,
          color: ColorsMeLivra().black.withOpacity(.38),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        disabledColor: ColorsMeLivra().black.withOpacity(.38),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsMeLivra().white,
        foregroundColor: ColorsMeLivra().purple,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20.scale,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: ColorsMeLivra().purple,
          fontFamily: FontsMeLivra.quicksand,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsMeLivra().white,
          statusBarIconBrightness: Brightness.light.opposite,
          statusBarBrightness: Brightness.light,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(ColorsMeLivra().black),
        fillColor: MaterialStateProperty.all<Color>(ColorsMeLivra().purple),
      ),
      iconTheme: IconThemeData(
        color: ColorsMeLivra().purple,
        size: 24.scale,
      ),
      primaryIconTheme: IconThemeData(
        color: ColorsMeLivra().purple,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(ColorsMeLivra().green),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        elevation: 4,
        shadowColor: ColorsMeLivra().purple.withOpacity(.2),
        margin: EdgeInsets.zero,
      ),
    );
