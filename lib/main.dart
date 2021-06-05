import 'package:flutter/material.dart';

import 'package:movie_app_21_2_21/src/pages/home_page.dart';
import 'package:movie_app_21_2_21/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'movieDetail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}
