import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/questions_page.dart';
import 'package:where_is_efi/screens/EnterScreen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // getData().then(
  //   (value) {
  //     print('test');
  //     questions = value;
  //     inspect(value);
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: elsewhereTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: EnterScreen()));
  }
}
