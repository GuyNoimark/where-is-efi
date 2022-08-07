import 'dart:html';
import 'package:flutter/material.dart';
import 'package:where_is_efi/screens/EnterScreen.dart';
import 'package:where_is_efi/widgets/button.dart';

import '../constants.dart';

class NameScreen extends StatefulWidget {
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "What's your name?",
              textScaleFactor: 8,
            ),
            const SizedBox(
              width: 500,
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'name',
                ),
              ),
            ),
            Button(text: "Submit", nextScreen: EnterScreen())
          ],
        ),
      ),
      decoration: BoxDecoration(gradient: bgGradient),
    );
  }
}
