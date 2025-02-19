import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/auth_cupit.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/layout_cubit.dart';
import 'package:movie_app/My_Theme/dark_theme.dart';
import 'package:movie_app/My_Theme/theme.dart';
import 'package:movie_app/Network/shared_pref.dart';
import 'package:movie_app/onboarding_screen.dart';
import 'package:movie_app/screens/Auth_Screens/forget_password_screen.dart';
import 'package:movie_app/screens/Auth_Screens/login_screen.dart';
import 'package:movie_app/screens/Auth_Screens/register_screen.dart';
import 'package:movie_app/screens/Home_Screens/home_screen.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'My_Provider/my_provider.dart';
import 'My_Theme/light_theme.dart';
import 'Network/local_network.dart';
import 'Observer/bloc_observer.dart';
import 'constants/constants.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  await EasyLocalization.ensureInitialized();

  // تعيين مراقب البلوك
  Bloc.observer = MyBlocObserver();

  // تحميل البيانات من التخزين المحلي
 // await CashNetwork.cashInitialization();

  // تحميل التوكن من CashNetwork و SharedPref
  //String? storedToken = CashNetwork.getCashData(key: 'token');
  //String? savedToken = await SharedPref.loadToken();
 // token = savedToken ?? storedToken;
  print("✅ Final Loaded Token: $token");

  // تحميل حالة الـ Onboarding
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboardingCompleted = prefs.getBool("onboardingCompleted") ?? false;

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

  const MovieApp({super.key, required this.isOnboardingCompleted, this.token});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    BaseLine lightTheme = LightTheme();
    BaseLine darkTheme = DarkTheme();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MoviesCubit()..getSources()),
        BlocProvider(create: (context) => LayoutCubit()..getUserData()),
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
            ? (token != null && token!.isNotEmpty
            ? HomeScreen.routeName
            : LoginScreen.routeName)
            : OnboardingScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          OnboardingScreen.routeName: (context) => OnboardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == MovieDetailsScreen.routeName) {
            final movieId = settings.arguments as int?;
            if (movieId == null) {
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Center(child: Text("Error: Movie ID is missing")),
                ),
              );
            }
            return MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movieId: movieId),
            );
          }
          return null;
        },
      ),
    );
  }
}
