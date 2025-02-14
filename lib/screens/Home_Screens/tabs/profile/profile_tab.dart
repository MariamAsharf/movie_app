import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 52, left: 24),
                            child: Image.asset("assets/images/gamer (1).png"),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("data",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    SizedBox(height: 25),
                                    Text("Wish List",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("data",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    SizedBox(height: 25),
                                    Text("History",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
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
                        child: Text("data",
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(220, 56)),
                              child: Text("Edit Profile"),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(135, 50),
                                  backgroundColor: Colors.red),
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
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.exit_to_app,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(height: 1,),
                      TabBar(
                       // labelColor: Colors.red, // تغيير لون النص عند التحديد
                        //unselectedLabelColor: Color(0xFFF6BD00), // لون النص عند عدم التحديد
                        indicatorColor: Color(0xFFF6BD00),
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.list,
                              color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
                              size: 35,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: "History",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
        ),
      ),
    );
  }
}
