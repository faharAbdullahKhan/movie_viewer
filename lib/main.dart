import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_viewer/UI/popular_movie_page.dart';
import 'package:movie_viewer/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_viewer/repositories/result_respository.dart';

import 'UI/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");
  int _mainScreenIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        navigatorKey: navigatorKey,
        initialRoute: (SplashScreen.id),
        home: BlocProvider(
          create: (context) => MovieBloc(repository: MovieRepositoryImpl()),
          child: PopularMoviePage(),
        ),
        // routes: {
        //   SplashScreen.id: (context) => SplashScreen(),
        // },
      ),
    );
  }
}
