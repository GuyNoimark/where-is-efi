import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_efi/screens/EnterScreen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<String> getJSON() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/44839ea0260575d91456'));
    return response.body;
  }

  void saveJSON(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('data') == null ? null : await prefs.remove('data');
    await prefs.setString('data', data);
    print('new data: ' + prefs.getString('data').toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Where is Efi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EnterScreen());
  }
}
