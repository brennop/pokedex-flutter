import 'package:flutter/material.dart';

/// TODO: add colors
const primaryColor = Color(0xffE51C44);

var theme = ThemeData(
  primaryColor: primaryColor,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    button: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    headline1: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Color(0xff565656),
      /* TODO: fontFamily: "Barlow" */
    ),
    /** pokemon info title */
    headline2: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      /* TODO: fontFamily: "Barlow" */
    ),
    /** pokemon card title */
    headline3: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff232323),
      /* TODO: fontFamily: "Barlow" */
    ),
    subtitle1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff838383),
      /* TODO: fontFamily: "Inter" */
    ),
    subtitle2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
      color: Color(0xff565656),
      /* TODO: fontFamily: "Barlow" */
    ),
    /** pokemon info subtitle */
    headline4: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      /* TODO: fontFamily: "Barlow" */
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(120.0, 56.0),
      primary: primaryColor,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xffe0e0e0),
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0)),
  ),
);
