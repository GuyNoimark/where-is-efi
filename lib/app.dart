import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/EnterScreen.dart';
import 'package:flutter/services.dart';
import 'package:where_is_efi/questions_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: elsewhereTheme,
        debugShowCheckedModeBanner: false,
        home: const LoadPage());
  }
}

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  LoadPageState createState() => LoadPageState();
}

class LoadPageState extends State {
  late final Future futureData;
  bool useLocalDeveloperQuestions = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
    futureData = getQuestions();
    // getData().then((value) => questions = convertData(value));
    // checkForInternet();
  }

  // Future<String> getData() async =>
  //     await rootBundle.loadString('assets/data.json');

  List<QuestionsData> convertData(String json) {
    return List.castFrom(jsonDecode(json))
        .map((data) => QuestionsData(data['question'], data['answer']))
        .toList();
  }

  Future<String> getData() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/2bcc0b5c2e5433f7fc00'));
    return response.body;
  }

  Future<bool> checkForInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  saveJsonOnDevice(String json) async {
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    localPreferences.setString('data', json);
  }

  Future getQuestions() async {
    bool hasInternetConnection = await checkForInternet();
    SharedPreferences localPreferences = await SharedPreferences.getInstance();

    if (!hasInternetConnection && !useLocalDeveloperQuestions) {
      print('No internet :( using old data');
      setState(() {
        questions = convertData(localPreferences.getString('data').toString());
      });
    } else if (!hasInternetConnection && useLocalDeveloperQuestions) {
      setState(() {
        questions = convertData('''
[
    {
        "answer": "C2",
        "question": "איפה הדוב הירוק?"
    },
    {
        "answer": "E2",
        "question": "איפה הפיל הורוד??"
    },
    {
        "answer": "I3",
        "question": "איפה הקוף הורוד?"
    },
    {
        "answer": "E4",
        "question": "איפה קפטן אמריקה?"
    },
    {
        "answer": "J3",
        "question": "איפה הצב המנוקד?"
    },
    {
        "answer": "L3",
        "question": "איפה הקוף הכתום?"
    },
    {
        "answer": "I1",
        "question": "איפה הכלב?"
    },
]
          ''');
      });
    } else {
      String json = await getData();
      setState(() {
        questions = convertData(json);
        saveJsonOnDevice(json);
      });
      print('Fetched from internet: $json');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            questions.shuffle();
            return const Scaffold(body: EnterScreen());
            // return const Scaffold(
            //     body: GameOverScreen(score: 200, name: 'Testi'));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Scaffold(
                body: Stack(
              children: const [
                // EnterScreen(),
                Center(child: CircularProgressIndicator()),
              ],
            ));
          }
        });
  }
}
