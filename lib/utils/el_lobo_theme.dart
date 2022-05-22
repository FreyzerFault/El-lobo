import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElLoboTheme {
  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.cyan,
    onPrimary: Colors.black,
    secondary: Colors.cyanAccent,
    onSecondary: Colors.black,
    outline: Colors.black,
    error: Colors.red,
    onError: Colors.white70,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white70,
    onSurface: Colors.black,
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.indigo,
    onPrimary: Colors.white,
    secondary: Colors.orange,
    onSecondary: Colors.white,
    outline: Colors.black,
    error: Colors.red,
    onError: Colors.black,
    background: Color(0xFF363636),
    onBackground: Colors.white54,
    surface: Colors.black12,
    onSurface: Colors.white54,
  );

  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      colorScheme: lightColorScheme,
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          return Colors.black;
        }),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: lightTextTheme.headline1,
        elevation: 5,
        backgroundColor: lightColorScheme.primary,
        iconTheme: IconThemeData(
          color: lightColorScheme.onPrimary,
        ),
        actionsIconTheme: IconThemeData(
          color: lightColorScheme.onPrimary,
          size: 35,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
      buttonTheme: ButtonThemeData(colorScheme: lightColorScheme),
      scaffoldBackgroundColor: lightColorScheme.background,
      primaryIconTheme: IconThemeData(color: lightColorScheme.onPrimary,
          size: 35
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(20),
          )
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: darkColorScheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: darkTextTheme.headline1,
        elevation: 5,
        backgroundColor: darkColorScheme.primary,
        iconTheme: IconThemeData(
          color: darkColorScheme.onPrimary,
        ),
        actionsIconTheme: IconThemeData(
          color: darkColorScheme.onPrimary,
          size: 35,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
      buttonTheme: ButtonThemeData(
        colorScheme: darkColorScheme,
      ),
      scaffoldBackgroundColor: darkColorScheme.background,
      primaryIconTheme: IconThemeData(color: darkColorScheme.onPrimary,
          size: 35
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(20),
        )
      ),
    );
  }
}
