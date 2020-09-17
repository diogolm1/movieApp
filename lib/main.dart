import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/stores/page_store.dart';
import 'package:movie_app/views/homePage.dart';
import 'package:http/http.dart' as http;

void main() async {
  await setupLocators();
  runApp(MyApp());
}

Future setupLocators() async {
  var client = http.Client();
  var response =
      await client.get('https://api.themoviedb.org/3/configuration?api_key=a1ee451bc60cbe60eccd78855de189ec');
  GetIt.I.registerSingleton<ApiConfiguration>(ApiConfiguration(jsonDecode(response.body)));

  GetIt.I.registerSingleton(PageStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Color.fromARGB(255, 198, 40, 40),
            primaryColorDark: Color.fromARGB(255, 142, 0, 0),
            primaryColorLight: Color.fromARGB(255, 255, 95, 82),
            accentColor: Color.fromARGB(255, 103, 58, 183)),
        home: HomePage());
  }
}
