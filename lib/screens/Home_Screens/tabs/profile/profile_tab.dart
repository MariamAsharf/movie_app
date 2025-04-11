import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile/history_content.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile/profile_widget.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile/watchlist_content.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<MoviesCubit>(context).getUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccessStates) {
          BlocProvider.of<MoviesCubit>(context).getUserData();
        }
      },
      builder: (context, state) {
        if (state is UserLoadingStates) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is FailedToUserStates) {
          return Center(child: Text(state.message));
        }
        if (state is UserSuccessStates) {
          return Column(
            children: [
              ProfileWidget(),
              Container(
                color: Theme.of(context).focusColor,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.amber,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                  tabs: [
                    Tab(
                        icon: Icon(
                          Icons.list,
                          size: 28,
                        ),
                        text: "Watch List"),
                    Tab(
                        icon: Icon(
                          Icons.folder,
                          size: 28,
                        ),
                        text: "History"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    WatchlistContent(),
                    HistoryContent(),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
