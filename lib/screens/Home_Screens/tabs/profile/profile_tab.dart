//import 'package:avatar_plus/avater_plus.dart' show AvaterPlus, AvaterPlus;
import 'package:avatar_plus/avatar_plus.dart' show AvatarPlus;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/layout_cubit.dart';
import 'package:movie_app/Blocs/layout_states.dart' show FailedToGetUserDataState, LayoutStates;
import 'package:movie_app/Network/shared_pref.dart' show SharedPref;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? token;

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchData();
  }

  Future<void> _loadTokenAndFetchData() async {
    token = await SharedPref.loadToken();
    print("🔄 Loaded Token: $token");

    if (token != null && mounted) {
      context.read<LayoutCubit>().getUserData();
      setState(() {});
    } else if (mounted) {
      context.read<LayoutCubit>().emit(FailedToGetUserDataState(error: "Token is missing"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var cubit = context.watch<LayoutCubit>();
        var userData = cubit.user2response?.data;

        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              body: userData == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 378,
                      color: Theme.of(context).focusColor,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 52, left: 24),
                                  child: AvatarPlus(
                                    userData.avaterId?.toString() ?? "", // حل نهائي
                                    height: 100,
                                    width: 94,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            userData.name ?? "Unknown",
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                          const SizedBox(height: 25),
                                          Text("Wish List", style: Theme.of(context).textTheme.titleSmall),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            userData.updatedAt ?? "N/A",
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                          const SizedBox(height: 25),
                                          Text("History", style: Theme.of(context).textTheme.titleSmall),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(right: 210),
                              child: Text("data", style: Theme.of(context).textTheme.titleSmall),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(minimumSize: const Size(220, 56)),
                                  child: const Text("Edit Profile"),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(135, 50),
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
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.exit_to_app, size: 20, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 1),
                            TabBar(
                              indicatorColor: const Color(0xFFF6BD00),
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.list, color: Theme.of(context).primaryColor, size: 35),
                                  child: const Text(
                                    "Wish List",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                  icon: Icon(Icons.folder, color: Theme.of(context).primaryColor, size: 35),
                                  child: const Text(
                                    "History",
                                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
