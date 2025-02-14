import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  changeTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode == ThemeMode.light;
    } else {
      themeMode == ThemeMode.dark;
    }
  }
}
