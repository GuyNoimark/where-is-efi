import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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

  bool enableFirebaseImages = false;

  Future getQuestionsAndImages() async {
    bool hasInternetConnection = await checkForInternet();
    SharedPreferences localPreferences = await SharedPreferences.getInstance();

    if (enableFirebaseImages) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseStorage.instanceFor(bucket: "gs://elsewhere-efi.appspot.com/");
    }

    if (hasInternetConnection) {
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
    } else {
      print('No internet :( using old data');
      setState(() {
        questions = convertData(localPreferences.getString('data').toString());
      });
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
