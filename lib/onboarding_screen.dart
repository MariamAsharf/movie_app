import 'package:flutter/material.dart';
import 'package:movie_app/screens/Auth_Screens/login_screen.dart';
import 'package:movie_app/shared/network/cache_network.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "Onboarding Screen";

  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  List<Map<String, dynamic>> onboardingData = [
    {
      "image": "assets/images/onboarding.png",
      "color": Color(0xFF121312).withAlpha(132),
      "title": "Find Your Next Favorite Movie Here",
      "body":
          "Get access to a huge library of movies to suit all tastes. You will surely like it."
    },
    {
      "image": "assets/images/onboarding (2).png",
      "color": Color(0xFF084250).withAlpha(132),
      "title": "Discover Movies",
      "body":
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease."
    },
    {
      "image": "assets/images/onboarding (3).png",
      "color": Color(0xFF85210E).withAlpha(132),
      "title": "Explore All Genres",
      "body":
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day."
    },
    {
      "image": "assets/images/onboarding (4).png",
      "color": Color(0xFF4C2471).withAlpha(132),
      "title": "Create Watchlists",
      "body":
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres."
    },
    {
      "image": "assets/images/onboarding (5).png",
      "color": Color(0xFF601321).withAlpha(132),
      "title": "Rate, Review, and Learn",
      "body":
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews."
    },
    {
      "image": "assets/images/onboarding (6).png",
      "color": Color(0xFF2A2C30).withAlpha(132),
      "title": "Start Watching Now",
      "body": ""
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image(
            image: AssetImage(onboardingData[currentIndex]['image']!),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: onboardingData[currentIndex]['color'],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color(0xFF121312),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    onboardingData[currentIndex]['title']!,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    onboardingData[currentIndex]['body']!,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentIndex == 0)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentIndex++;
                            });
                          },
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 12),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).primaryColor),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Explore Now",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      if (currentIndex == 1)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentIndex++;
                            });
                          },
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 12),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).primaryColor),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      if (currentIndex > 1) ...[
                        ElevatedButton(
                          onPressed: () async {
                            if (currentIndex < onboardingData.length - 1) {
                              setState(() {
                                currentIndex++;
                              });
                            } else {
                              await CacheNetwork.insertToCache(
                                  key: "onboarding_done", value: "true");

                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            }
                          },
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 12),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).primaryColor),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              currentIndex == onboardingData.length - 1
                                  ? 'Finish'
                                  : 'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentIndex--;
                            });
                          },
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 12),
                            ),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Back",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
