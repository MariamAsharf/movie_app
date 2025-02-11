import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile_tab.dart';
import 'package:movie_app/screens/Home_Screens/tabs/search_tab.dart';
import 'package:movie_app/screens/Home_Screens/tabs/explore_tab.dart';
import 'package:movie_app/screens/Home_Screens/tabs/Home/home_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Screen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().getSources();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is FailedToSourceStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: tabs[selectedIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BottomNavigationBar(
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.explore,
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    ExploreTab(),
    SearchTab(),
    ProfileTab(),
  ];
}
