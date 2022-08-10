import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/questions_page.dart';
import 'package:where_is_efi/EnterScreen.dart';

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
    super.initState();
    checkForInternet();
  }

  Future<String> getData() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/44839ea0260575d91456'));
    return response.body;
  }

  List<QuestionsData> convertData(String json) {
    return List.castFrom(jsonDecode(json)['questions'])
        .map((data) => QuestionsData(data['question'], data['answer']))
        .toList();
  }

  checkForInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    SharedPreferences localPreferences = await SharedPreferences.getInstance();

    if (result == true) {
      getData().then((value) {
        setState(() {
          questions = convertData(value);
          localPreferences.setString('data', value);
          print('Fetched from internet: ' + value);
        });
      });
    } else {
      print('No internet :( using old data');
      setState(() {
        questions = convertData(localPreferences.getString('data').toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(body: Scaffold(body: EnterScreen()));
  }
}
