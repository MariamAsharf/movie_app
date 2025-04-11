import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/My_Theme/theme.dart';

class DarkTheme extends BaseLine {
  @override
  Color get scaffoldBackgroundColor => Color(0xFF121312);

  @override
  Color get primaryColor => Color(0xFFF6BD00);

  @override
  Color get focusColor => Color(0xFF282A28);

  @override
  Color get textColor => Color(0xFFFFFFFF);

  @override
  ThemeData get themeData => ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: scaffoldBackgroundColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: primaryColor),
        ),
        primaryColor: primaryColor,
        focusColor: focusColor,
        textTheme: TextTheme(
          titleSmall: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
          titleMedium: GoogleFonts.roboto(
              fontSize: 20, fontWeight: FontWeight.w700, color: textColor),
          titleLarge: GoogleFonts.roboto(
              fontSize: 24, fontWeight: FontWeight.w700, color: textColor),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: focusColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: textColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primaryColor),
          ),
        ),
      );
}
