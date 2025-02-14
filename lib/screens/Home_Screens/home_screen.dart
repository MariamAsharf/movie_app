import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/screens/Home_Screens/tabs/Home/home_tab.dart';
import 'package:movie_app/screens/Home_Screens/tabs/explore_tab.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile/profile_tab.dart';
import 'package:movie_app/screens/Home_Screens/tabs/search_tab.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "Home Screen";

  HomeScreen({super.key});

  final List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    ExploreTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is SourceLoadingStates) {
          showDialog(
            context: context,
            builder: (context) => Center(child: CircularProgressIndicator()),
          );
        } else if (state is FailedToSourceStates) {
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
        var cubit = BlocProvider.of<MoviesCubit>(context);

        return SafeArea(
          child: Scaffold(
            body: tabs[cubit.currentTabIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BottomNavigationBar(
                currentIndex: cubit.currentTabIndex,
                onTap: (index) {
                  cubit.onItemSelected(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
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
}
