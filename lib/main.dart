import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/Blocs/auth_cupit.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/My_Theme/dark_theme.dart';
import 'package:movie_app/My_Theme/theme.dart';
import 'package:movie_app/onboarding_screen.dart';
import 'package:movie_app/screens/Auth_Screens/forget_password_screen.dart';
import 'package:movie_app/screens/Auth_Screens/login_screen.dart';
import 'package:movie_app/screens/Auth_Screens/register_screen.dart';
import 'package:movie_app/screens/Home_Screens/home_screen.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details_screen.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile/edit_profile.dart';
import 'package:movie_app/shared/network/cache_network.dart';
import 'package:movie_app/shared/network/user_cache_server.dart';
import 'package:provider/provider.dart';

import 'Model/movie.dart';
import 'My_Provider/my_provider.dart';
import 'My_Theme/light_theme.dart';
import 'Observer/bloc_observer.dart';
import 'constants/constants.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  final onboardingDone = CacheNetwork.getCacheData(key: 'onboarding_done');
  token = CacheNetwork.getCacheData(key: 'token');
  print("token is : $token");
  print("Onboarding Done: $onboardingDone");
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('favouritesBox');
  await UserCacheServer.init();
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MovieApp(
        token: token,
        onboardingDone: onboardingDone == "true",
      ),
    ),
  ));
}

class MovieApp extends StatelessWidget {
  final String? token;
  final bool onboardingDone;

  const MovieApp({
    super.key,
    required this.token,
    required this.onboardingDone,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    BaseLine lightTheme = LightTheme();
    BaseLine darkTheme = DarkTheme();

    String initialRoute;
    if (!onboardingDone) {
      initialRoute = OnboardingScreen.routeName;
    } else if (token != null && token!.isNotEmpty) {
      initialRoute = HomeScreen.routeName;
    } else {
      initialRoute = LoginScreen.routeName;
    }

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
        initialRoute: initialRoute,
        routes: {
          EditProfile.routeName: (context) => EditProfile(),
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
