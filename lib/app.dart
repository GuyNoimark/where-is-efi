import 'dart:convert';
import 'dart:developer';
// import 'dart:html';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

import 'firebase_options.dart';

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
  late final Future futureData;
  bool enableFirebaseImages = false;
  bool useLocalDeveloperQuestions = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
    futureData = getQuestionsAndImages();
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
        await http.get(Uri.parse('https://api.npoint.io/44839ea0260575d91456'));
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

  Future getQuestionsAndImages() async {
    bool hasInternetConnection = await checkForInternet();
    SharedPreferences localPreferences = await SharedPreferences.getInstance();

    if (enableFirebaseImages) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseStorage.instanceFor(bucket: "gs://elsewhere-efi.appspot.com/");
    }

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
    {
        "answer": "L1",
        "question": "איפה הדובי השחור?"
    },
    {
        "answer": "H3",
        "question": "איפה מיני מאוס?"
    },
    {
        "answer": "H2",
        "question": "איפה הנמר עם המשקפת?"
    },
    {
        "answer": "K3",
        "question": "איפה אלמו מרחוב סומסום?"
    },
    {
        "answer": "C1",
        "question": "איפה פו הדוב?"
    },
    {
        "answer": "E3",
        "question": "איפה האוגר עם הלב?"
    },
    {
        "answer": "E1",
        "question": "איפה הדרקון האדום?"
    },
    {
        "answer": "B4",
        "question": "איפה הכלב הדלמטי?"
    },
    {
        "answer": "F3",
        "question": "איפה כלב הים?"
    },
    {
        "answer": "A2",
        "question": "איפה הברווז הסגול?"
    },
    {
        "answer": "G2",
        "question": "איפה הצב הכחול?"
    },
    {
        "answer": "G4",
        "question": "איפה הקוף הירוק?"
    },
    {
        "answer": "C4",
        "question": "איפה הזאב לבן אדום?"
    }
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

      if (enableFirebaseImages) {
        // ADD Firebase
        ListResult imagesRef =
            await FirebaseStorage.instance.ref('/images').listAll();
        for (Reference image in imagesRef.items) {
          String link = await image.getDownloadURL();
          images.add(CachedNetworkImage(imageUrl: link));
        }
        print('Fetched ${images.length} images from internet');
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return FutureBuilder(
        future: futureData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(body: EnterScreen());
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
