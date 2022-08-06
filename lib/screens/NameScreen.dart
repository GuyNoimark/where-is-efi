import 'dart:html';

import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      body: Container(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "What's your name?",
              textScaleFactor: 3,
            ),
            const Padding(padding: EdgeInsets.all(8)),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  gapPadding: 8,
                ), //TODO need to see how to work with it
                labelText: 'name',
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(onPressed: () {}, child: Text("button"))
          ],
        ),
      )),
    );
  }
}
