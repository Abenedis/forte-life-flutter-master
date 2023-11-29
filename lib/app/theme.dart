import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimen.dart';

class StandardTheme {
  static ThemeData create() {
    return ThemeData(
      primaryColor: StandardColors.primaryColor,
      accentColor: StandardColors.accentColor,
      scaffoldBackgroundColor: StandardColors.accentColor,
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: _createTextTheme(),
      primaryTextTheme: _createPrimaryTextTheme(),
      inputDecorationTheme: _createInputDecorationTheme(),
      buttonTheme: _createButtonThemeData(),
    );
  }

  static TextTheme _createTextTheme() {
    return const TextTheme(
      subhead: const TextStyle(
        fontSize: StandardDimensions.normal,
        color: StandardColors.selectedColor,
      ),
      body1: const TextStyle(
        fontSize: StandardDimensions.normal,
        color: StandardColors.selectedColor,
      ),
      caption: const TextStyle(
        fontSize: StandardDimensions.smaller,
        color: StandardColors.selectedColor,
      ),
      button: const TextStyle(
        fontSize: StandardDimensions.normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextTheme _createPrimaryTextTheme() {
    return const TextTheme(
      title: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static InputDecorationTheme _createInputDecorationTheme() {
    return const InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: StandardColors.unselectedColor,
          width: StandardDimensions.textFieldBorder,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: StandardColors.unselectedColor,
          width: StandardDimensions.textFieldBorder,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: StandardColors.selectedColor,
          width: StandardDimensions.textFieldBorder,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: StandardColors.errorColor,
          width: StandardDimensions.textFieldBorder,
        ),
      ),
      labelStyle: const TextStyle(color: StandardColors.unselectedColor),
      hintStyle: const TextStyle(color: StandardColors.unselectedColor),
      contentPadding: const EdgeInsets.all(StandardDimensions.smaller),
    );
  }

  static ButtonThemeData _createButtonThemeData() {
    return const ButtonThemeData(
      padding: const EdgeInsets.all(StandardDimensions.normal),
      textTheme: ButtonTextTheme.primary,
      buttonColor: StandardColors.primaryColor,
    );
  }
}
