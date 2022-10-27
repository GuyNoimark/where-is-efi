import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:where_is_efi/models/questions_model.dart';

Color bgColor1 = Color.fromARGB(255, 222, 26, 90);
Color bgColor2 = Color.fromARGB(255, 247, 14, 115);
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
  // inputDecorationTheme: InputDecorationTheme(
  //   fillColor: Colors.whi,
  // border: UnderlineInputBorder(borderRadius: defaultBorderRadius),
  //   enabledBorder: UnderlineInputBorder(
  //     borderRadius: defaultBorderRadius,
  //     borderSide: BorderSide(width: 3, color: secondary),
  //   ),
  //   focusedBorder: UnderlineInputBorder(
  //     borderRadius: defaultBorderRadius,
  //     // borderSide: BorderSide(width: 3, color: Colors.yellow),
  //   ),
  // ),
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

List<QuestionsData> questions = [];

List<CachedNetworkImage> images = [];
