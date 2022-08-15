import 'dart:convert';
import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/questions_page.dart';
import 'package:where_is_efi/EnterScreen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: elsewhereTheme,
        debugShowCheckedModeBanner: false,
        home: LoadPage());
  }
}

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  LoadPageState createState() => LoadPageState();
}

class LoadPageState extends State {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    getData().then((value) => questions = convertData(value));
  }

  Future<String> getData() async => await rootBundle.loadString('data.json');

  List<QuestionsData> convertData(String json) {
    return List.castFrom(jsonDecode(json)['questions'])
        .map((data) => QuestionsData(data['question'], data['answer']))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(body: Scaffold(body: EnterScreen()));
  }
}
