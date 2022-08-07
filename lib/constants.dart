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
    enabledBorder: OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: BorderSide(width: 3, color: secondary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: BorderSide(width: 3, color: Colors.deepPurple),
    ),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    borderRadius: defaultBorderRadius,
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: secondary),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: secondary,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? Colors.grey.withOpacity(0.3)
                  : null;
            },
          ),
          animationDuration: Duration(milliseconds: 1000),
          backgroundColor: MaterialStateProperty.all(secondary),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          )))),
);
