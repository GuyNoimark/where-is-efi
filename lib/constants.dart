import 'dart:io';

import 'package:flutter/material.dart';

Color bgColor1 = const Color.fromARGB(255, 90, 113, 237);
Color bgColor2 = const Color.fromARGB(255, 14, 171, 247);
LinearGradient bgGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      bgColor1,
      bgColor2,
    ]);

Color secondary = Colors.white;

BorderRadius defaultBorderRadius = BorderRadius.circular(20);

final ThemeData elsewhereTheme = ThemeData.dark().copyWith(
  // textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: defaultBorderRadius),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    borderRadius: defaultBorderRadius,
  ),

  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: secondary),
  // elevatedButtonTheme:
  // ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: secondary)),
);
