import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/screens/Auth_Screens/login_screen.dart';
import 'package:movie_app/screens/Home_Screens/tabs/profile/edit_profile.dart';
import 'package:movie_app/shared/network/cache_network.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MoviesCubit>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, right: 16, left: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BlocBuilder<MoviesCubit, MoviesStates>(
                      builder: (context, state) {
                        if (state is UserSuccessStates) {
                          return CircleAvatar(
                            child: AvatarPlus(
                              "${cubit.userModel?.data?.avaterId ?? 0}",
                              fit: BoxFit.fill,
                            ),
                            radius: 60,
                          );
                        }
                        return CircleAvatar(radius: 60);
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      "${cubit.userModel?.data?.name ?? "No Name"}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "12",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Watch List",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "13",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "History",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      EditProfile.routeName,
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 48, vertical: 15),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      Color(0xFFF6BD00),
                    ),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await CacheNetwork.deleteCacheMovie(key: 'token');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You have logged out successfully!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                          (route) => false,
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFFE82626),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Exit",
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
