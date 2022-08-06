import 'dart:html';
import 'NameScreen.dart';
import 'package:flutter/material.dart';
import 'package:where_is_efi/screens/NameScreen.dart';

class EnterScreen extends StatefulWidget {
  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello!")),
      body: Container(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("ElseWhere"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (final BuildContext context) =>
                              NameScreen()));
                },
                child: Text("button"))
          ],
        ),
      )),
    );
  }
}
