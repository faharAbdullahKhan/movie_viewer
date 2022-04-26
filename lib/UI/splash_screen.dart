import 'package:flutter/material.dart';
import 'dart:async';

import 'package:movie_viewer/UI/popular_movie_page.dart';

class SplashScreen extends StatefulWidget {

  static String id = "splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  static int SPLASH_DURATION = 3;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: SPLASH_DURATION),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => PopularMoviePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/food001.png',
                  width: 250,
                  height: 70,
                ),
                // Visibility(visible: false,child: Text(tr("let_get_you_hired")))
              ],
            ),
          ),
        ],
      ),
    );
  }
}