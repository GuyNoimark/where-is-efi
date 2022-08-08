import 'dart:html';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:where_is_efi/questions_page.dart';
import 'package:where_is_efi/screens/EnterScreen.dart';
import 'package:where_is_efi/widgets/Button.dart';

import '../constants.dart';

class NameScreen extends StatefulWidget {
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _countDownController = CountDownController();
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
            const Button(
              text: "Submit",
              nextScreen: QuestionPage(),
              // child: NeonCircularTimer(
              //   duration: 60,
              //   controller: _countDownController,
              //   width: 200,
              //   isReverse: true,
              // ),
            ) //TODO: question screen
          ],
        ),
      ),
      decoration: BoxDecoration(gradient: bgGradient),
    );
  }
}
