import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:umit_movies/src/pages/homePage.dart';
import 'package:umit_movies/src/theme/colors.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const UmitMovieApp());
}

class UmitMovieApp extends StatelessWidget {
  const UmitMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: primaryColor2,
        ),
      ),
      home: const MovieSearchPage(),
    );
  }
}


