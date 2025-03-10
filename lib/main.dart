import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/auth_cupit.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/My_Theme/dark_theme.dart';
import 'package:movie_app/My_Theme/theme.dart';
import 'package:movie_app/Network/local_network.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/onboarding_screen.dart';
import 'package:movie_app/screens/Auth_Screens/forget_password_screen.dart';
import 'package:movie_app/screens/Auth_Screens/login_screen.dart';
import 'package:movie_app/screens/Auth_Screens/register_screen.dart';
import 'package:movie_app/screens/Home_Screens/home_screen.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details_screen.dart';
//import 'package:movie_app/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'My_Provider/my_provider.dart';
import 'My_Theme/light_theme.dart';
import 'Observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
 await CashNetwork.cashIntialization();
token = CashNetwork.getCashData(key: 'token');
print("token is ");

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isOnboardingCompleted = prefs.getBool("onboardingCompleted") ?? false;
  //String? token = prefs.getString("token");

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MovieApp(
          isOnboardingCompleted: isOnboardingCompleted,
          token: token,
        ),
      ),
    ),
  );
}

class MovieApp extends StatelessWidget {
  final bool isOnboardingCompleted;
  final String? token;
  const MovieApp({super.key,required this.isOnboardingCompleted, this.token});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    BaseLine lightTheme = LightTheme();
    BaseLine darkTheme = DarkTheme();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MoviesCubit()..getSources()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme.themeData,
        darkTheme: darkTheme.themeData,
        themeMode: provider.themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: isOnboardingCompleted
            ? (token != null  ? HomeScreen.routeName : LoginScreen.routeName)
            : OnboardingScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          OnboardingScreen.routeName: (context) => OnboardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
         // ProfileScreen.routeName: (context) => ProfileScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == MovieDetailsScreen.routeName) {
            final args = settings.arguments as int?;
            if (args == null) {
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Center(child: Text("Error: Movie ID is missing")),
                ),
              );
            }
            return MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(),
              settings: RouteSettings(arguments: args),
            );
          }
          return null;
        },

      ),
    );
  }
}

