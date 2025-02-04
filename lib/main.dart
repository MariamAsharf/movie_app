import 'package:flutter/material.dart';
import 'package:movie_app/My_Theme/dark_theme.dart';
import 'package:movie_app/My_Theme/theme.dart';
import 'package:provider/provider.dart';

import 'My_Provider/my_provider.dart';
import 'My_Theme/light_theme.dart';

void main() async {
  runApp(
    await ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    BaseLine lightTheme = LightTheme();
    BaseLine darkTheme = DarkTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme.themeData,
      darkTheme: darkTheme.themeData,
      themeMode: provider.themeMode,
    );
  }
}
