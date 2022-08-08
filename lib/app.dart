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

  Future<List<QuestionsData>> getData() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/44839ea0260575d91456'));
    return List.castFrom(jsonDecode(response.body)['questions'])
        .map((data) => QuestionsData(data['question'], data['answer']))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: elsewhereTheme,
        home: FutureBuilder<Object>(
            future: getData(),
            builder: (context, snapshot) {
              inspect(snapshot.data);
              return Scaffold(body: EnterScreen());
            }));
  }
}
