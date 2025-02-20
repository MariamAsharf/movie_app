import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/layout_cubit.dart';
import 'package:movie_app/Model/user_prof.dart';

import '../../../../Blocs/layout_states.dart';
import '../../../../Model/user_prof.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is FailedToGetUserDataState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              body: state is GetUserDataLoadingState
                  ? Center(child: CircularProgressIndicator())
                  : cubit.userProf != null
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 378,
                                color: Theme.of(context).focusColor,
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 52, left: 24),
                                            child: AvatarPlus(
                                              "${cubit.userProf!.data!.avaterId}",
                                              height: 100,
                                              width: 94,
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${cubit.userProf!.data!.name}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    SizedBox(height: 25),
                                                    Text(
                                                      "Wish List",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${cubit.userProf!.data!.updatedAt}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    SizedBox(height: 25),
                                                    Text(
                                                      "History",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.only(right: 210),
                                        child: Text(
                                          "data",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(220, 56),
                                            ),
                                            child: Text("Edit Profile"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(135, 50),
                                              backgroundColor: Colors.red,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Exit",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(
                                                  Icons.exit_to_app,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1),
                                      TabBar(
                                        indicatorColor: Color(0xFFF6BD00),
                                        tabs: [
                                          Tab(
                                            icon: Icon(
                                              Icons.list,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 35,
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                text: "Wish List",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            icon: Icon(
                                              Icons.folder,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 35,
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                text: "History",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 130),
                                child: Image.asset("assets/images/Empty 1.png"),
                              ),
                            ],
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
