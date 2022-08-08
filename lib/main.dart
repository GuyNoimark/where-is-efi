import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';
import 'package:where_is_efi/app.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';

void main() {
  Future<List<QuestionsData>> getData() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/44839ea0260575d91456'));
    return List.castFrom(jsonDecode(response.body)['questions'])
        .map((data) => QuestionsData(data['question'], data['answer']))
        .toList();
  }

  getData().then(
    (value) {
      questions = value;
      runApp(const App());
    },
  );
}
