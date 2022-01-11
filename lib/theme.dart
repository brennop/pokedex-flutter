import 'package:flutter/material.dart';

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
    subtitle1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff838383),
      /* TODO: fontFamily: "Inter" */ 
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
