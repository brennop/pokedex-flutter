import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// TODO: add colors
const primaryColor = Color(0xffE51C44);

var theme = ThemeData(
  fontFamily: GoogleFonts.inter().fontFamily,
  primaryColor: primaryColor,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
      button: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      headline1: GoogleFonts.barlow(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: const Color(0xff565656),
      ),
      /** pokemon info title */
      headline2: GoogleFonts.barlow(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      /** pokemon card title */
      headline3: GoogleFonts.barlow(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: const Color(0xff232323),
      ),
      subtitle1: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Color(0xff838383),
      ),
      subtitle2: GoogleFonts.barlow(
        fontSize: 16.0,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        color: const Color(0xff565656),
      ),
      /** pokemon info subtitle */
      headline4: GoogleFonts.barlow(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: const Color(0xfff6f6f6),
      )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(120.0, 56.0),
      primary: primaryColor,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        primary: primaryColor,
        textStyle: const TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        )),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xffe0e0e0),
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0)),
  ),
);

extension TextThemes on TextTheme {
  TextStyle get infoLabel {
    return const TextStyle(
      color: Color(0xff565656),
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get infoValue {
    return GoogleFonts.barlow(
      color: const Color(0xff565656),
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
    );
  }
}
