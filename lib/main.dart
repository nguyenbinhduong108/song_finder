import 'package:flutter/material.dart';
import 'package:song_finder/screen/home_page.dart';
import 'package:song_finder/screen/info_page.dart';
import 'package:song_finder/screen/sign_in.dart';
import 'package:song_finder/screen/song_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const SongPage(),
      debugShowCheckedModeBanner: false
    );
  }
}
