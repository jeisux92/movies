import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail()
      },
    );
  }
}
