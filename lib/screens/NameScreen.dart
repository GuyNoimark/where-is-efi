import 'dart:html';
import 'package:flutter/material.dart';
import 'package:where_is_efi/screens/EnterScreen.dart';
import 'package:where_is_efi/widgets/Button.dart';

import '../constants.dart';

class NameScreen extends StatefulWidget {
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final myController = TextEditingController();
  @override
  Widget build(final BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "What's your name?",
              textScaleFactor: 5,
            ),
            SizedBox(
              width: 500,
              height: 60,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'name',
                ),
                controller: myController,
                cursorColor: Colors.white,
              ),
            ),
            Button(
                text: "Submit", nextScreen: Container()) //TODO: question screen
          ],
        ),
      ),
      decoration: BoxDecoration(gradient: bgGradient),
    );
  }
}
