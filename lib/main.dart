import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/My_Theme/dark_theme.dart';
import 'package:movie_app/My_Theme/theme.dart';
import 'package:movie_app/authentication/auth_cupit.dart';
import 'package:movie_app/screens/Login_Screens/forget_password_screen.dart';
import 'package:movie_app/screens/Login_Screens/login_screen.dart';
import 'package:movie_app/screens/Login_Screens/register_screen.dart';
import 'package:provider/provider.dart';

import 'My_Provider/my_provider.dart';
import 'My_Theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MovieApp(),
    ),
  ));
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    BaseLine lightTheme = LightTheme();
    BaseLine darkTheme = DarkTheme();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme.themeData,
        darkTheme: darkTheme.themeData,
        themeMode: provider.themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(
                title: '',
              ),
          ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        },
      ),
    );
  }
}
