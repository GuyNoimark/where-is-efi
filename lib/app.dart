import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/questions_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<String> getJSON() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/44839ea0260575d91456'));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: elsewhereTheme,
        home: Scaffold(body: QuestionPage()));
  }
}
