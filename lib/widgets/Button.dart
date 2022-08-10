import 'dart:html';

import 'package:flutter/material.dart';

import '../constants.dart';

class Button extends StatelessWidget {
  const Button({required this.text, required this.nextScreen, this.onTap});
  final String text;
  final Widget nextScreen;
  final Function? onTap;
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: 500,
      height: 60, // specific value
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: secondary,
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
        onPressed: () {
          // onTap!();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (final BuildContext context) => Scaffold(
                        body: nextScreen,
                      )));
        },
        child: Text(text,
            style: TextStyle(
                color: bgColor1, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
