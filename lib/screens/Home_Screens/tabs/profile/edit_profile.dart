import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/shared/network/cache_network.dart';

import 'bottom_sheet_avatar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  static const String routeName = "Edit Profile";

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MoviesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick Avatar",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 36),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Theme.of(context).focusColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    builder: (context) {
                      return BottomSheetAvatar();
                    },
                    isScrollControlled: true,
                    context: context);
              },
              child: CircleAvatar(
                child: AvatarPlus(
                  "${cubit.userModel?.data?.avaterId ?? cubit.selectedAvaterId}",
                ),
                radius: 60,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  SizedBox(width: 14),
                  Text(
                    "${cubit.userModel?.data?.name ?? ""}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  SizedBox(width: 14),
                  Text(
                    "${cubit.userModel?.data?.phone ?? ""}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                String? token = CacheNetwork.getCacheData(key: 'token');
                if (token != null && token.isNotEmpty) {
                  await cubit.deleteAccount(token, context);
                  await CacheNetwork.deleteCacheMovie(key: 'token');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Token is not available"),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 48, vertical: 15),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xFFE82626),
                ),
              ),
              child: Text(
                "Delete Account",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 16),
            BlocConsumer<MoviesCubit, MoviesStates>(
              listener: (context, state) {
                if (state is UpdateUserSuccessStates) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Data Updated Successfully.."),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Future.delayed(Duration(milliseconds: 500), () {
                    Navigator.pop(context, true);
                  });
                }
                if (state is FailedToUpdateUserStates) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final email = cubit.userModel?.data?.email;
                    final avaterId = cubit.userModel?.data?.avaterId;
                    if (email!.isNotEmpty && avaterId != null) {
                      cubit.updateUserData(email: email, avaterId: avaterId);
                    }
                  },
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 48, vertical: 15),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xFFF6BD00),
                    ),
                  ),
                  child: Text(
                    state is UpdateUserLoadingStates
                        ? "Loading..."
                        : "Update Data",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                );
              },
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
