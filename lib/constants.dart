import 'dart:io';

import 'package:flutter/material.dart';

Color bgColor1 = const Color.fromARGB(255, 90, 113, 237);
Color bgColor2 = const Color.fromARGB(255, 14, 171, 247);
LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      bgColor1,
      bgColor2,
    ]);

Color secondary = Colors.white;
