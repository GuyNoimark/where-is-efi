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
      appBar: AppBar(title: Text("hello!")),
      body: Container(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("name"),
            ElevatedButton(onPressed: () {}, child: Text("button"))
          ],
        ),
      )),
    );
  }
}
