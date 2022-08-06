import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<String> getJSON() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/GuyNoimark/where-is-efi/main/assets/data.json?token=GHSAT0AAAAAABXLMUMKCPDCZN37DFFIMT3OYXODHCQ'));

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('test'),
            ),
            body: Center(
                child: FutureBuilder<String>(
              future: getJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ))));
  }
}
