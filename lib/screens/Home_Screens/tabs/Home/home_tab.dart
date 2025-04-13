import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MoviesCubit>(context);

    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is SourceSuccessStates) {
          print("🎬 Movies loaded successfully!");
        } else if (state is FailedToSourceStates) {
          print("⚠️ Error: ${state.message}");
        }
      },
      builder: (context, state) {
        if (state is SourceLoadingStates) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is FailedToSourceStates) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is SourceSuccessStates && cubit.sources.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/images/available.png",
                        width: 220, height: 80),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 13,
                      viewportFraction: 0.6,
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: cubit.sources.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              if (movie.id != null) {
                                Navigator.pushNamed(
                                  context,
                                  MovieDetailsScreen.routeName,
                                  arguments: movie.id,
                                ).then((result) {
                                  if (result == true) {
                                    cubit.getSources();
                                  }
                                });
                              }
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 450,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withAlpha(165),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          movie.voteAverage
                                                  ?.toStringAsFixed(1) ??
                                              '0.0',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.star,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 15),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/images/watch.png"),
                  ),
                  Row(
                    children: [
                      Text("Action",
                          style: Theme.of(context).textTheme.titleSmall),
                      Spacer(),
                      Text(
                        "See more",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.arrow_forward,
                          size: 15, color: Theme.of(context).primaryColor),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      itemCount: cubit.sources.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final movie = cubit.sources[index];
                            if (movie.id != null) {
                              Navigator.pushNamed(
                                context,
                                MovieDetailsScreen.routeName,
                                arguments: movie.id,
                              ).then((result) {
                                if (result == true) {
                                  cubit.getSources();
                                }
                              });
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${cubit.sources[index].posterPath}",
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withAlpha(165),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          cubit.sources[index].voteAverage
                                                  ?.toStringAsFixed(1) ??
                                              '0.0',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.star,
                                            color: Theme.of(context).primaryColor,
                                            size: 15),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: Text("No Movies Available"));
      },
    );
  }
}
