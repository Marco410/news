import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class ColorStyle {
  static const primaryColor = Color(0xFF46AFFE);
  static const errorColor = Colors.redAccent;
  static const blueLight = Color(0xFFDBF7FF);
}

class TxtStyle {
  static final headerStyle = TextStyle(
      fontFamily: "Poppins",
      fontSize: 10.f,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
      letterSpacing: 1.5);

  static final labelStyle = TextStyle(
      fontFamily: "Poppins",
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 6.f);
}

class ShadowStyle {
  static const generalShadow = [
    BoxShadow(
      color: Color(0x26AAA9A9),
      blurRadius: 8,
      spreadRadius: 5,
      offset: Offset(0, 0),
    )
  ];

  static List<BoxShadow> containerShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 4,
        spreadRadius: 0,
        offset: const Offset(0, 0))
  ];
}
