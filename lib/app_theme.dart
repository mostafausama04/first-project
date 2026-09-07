import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFE1BEE7);
const Color kAccentColor = Color(0xFFF8BBD0);
const Color kDarkTextColor = Color(0xFF333333);
const Color kLightTextColor = Color(0xFF888888);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  colorSchemeSeed: kPrimaryColor,
  textTheme: ThemeData.light().textTheme.copyWith(
        displayLarge: const TextStyle(
            color: kDarkTextColor,
            fontSize: 28,
            fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(
            color: kDarkTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        bodyMedium: const TextStyle(color: kLightTextColor, fontSize: 16),
      ),
);