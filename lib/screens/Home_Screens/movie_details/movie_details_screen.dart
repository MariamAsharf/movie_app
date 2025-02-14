import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Blocs/movies_cubit.dart';
import '../../../Blocs/movies_states.dart';
import '../home_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/movieDetails';
  final int movieId;

  MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    print("🟢 MovieDetailsScreen Loaded with ID: $movieId");
    if (movieId == null) {
      return Scaffold(
        body: Center(
          child: Text("Error: Movie ID is missing"),
        ),
      );
    }

    var cubit = BlocProvider.of<MoviesCubit>(context);

    Future.microtask(() {
      cubit.getMovieDetailsById(movieId);
      cubit.getMovieImagesById(movieId);
      cubit.getMovieCreditsById(movieId);
    });

    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is FailedToDetailsStates) {
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
            body: state is DetailsLoadingStates
                ? Center(child: CircularProgressIndicator())
                : cubit.movieDetailsResponse != null
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Image.network(
                                  "https://image.tmdb.org/t/p/w500${cubit.movieDetailsResponse?.posterPath}",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, right: 16, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context,true);
                                            },
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.bookmark_rounded,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 28),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/play.png"),
                                      ),
                                      SizedBox(height: 62),
                                      Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withAlpha(190),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                cubit.movieDetailsResponse!
                                                        .title! ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                cubit.movieDetailsResponse!
                                                        .releaseDate! ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(vertical: 16),
                                      ),
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.red),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Watch",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(right: 8),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Theme.of(context).focusColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 9),
                                            Text(
                                              cubit.movieDetailsResponse!
                                                      .voteCount!
                                                      .toString() ??
                                                  "0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(right: 8),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Theme.of(context).focusColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.watch_later,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 9),
                                            Text(
                                              cubit.movieDetailsResponse!
                                                      .runtime!
                                                      .toString() ??
                                                  "0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Theme.of(context).focusColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 9),
                                            Text(
                                              cubit.movieDetailsResponse!
                                                      .voteAverage!
                                                      .toStringAsFixed(1) ??
                                                  "0.0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Screen Shots",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                              "https://image.tmdb.org/t/p/w500${cubit.imagesResponse!.backdrops![index].filePath}"),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 13),
                                      itemCount: 6,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Similar",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          cubit.sourceResponse!.results!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            final selectedMovieId = cubit
                                                .sourceResponse!
                                                .results![index]
                                                .id;
                                            print(
                                                "🚀 Navigating to MovieDetailsScreen with ID: $selectedMovieId");

                                            if (selectedMovieId != null) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailsScreen.routeName,
                                                arguments: selectedMovieId,
                                              );
                                            } else {
                                              print(
                                                  "⚠️ Error: Selected Movie ID is null");
                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.topLeft,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                    "https://image.tmdb.org/t/p/w500${cubit.sourceResponse!.results![index].posterPath}"),
                                              ),
                                              Positioned(
                                                top: 8,
                                                left: 10,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withAlpha(165),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        cubit.movieDetailsResponse!
                                                                .voteAverage!
                                                                .toStringAsFixed(
                                                                    1) ??
                                                            '0.0',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Icon(Icons.star,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          size: 15),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Summary",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    cubit.movieDetailsResponse!.overview! ?? "",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Cast",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).focusColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    "https://image.tmdb.org/t/p/w500${cubit.creditsResponse!.cast![index].profilePath!}",
                                                    fit: BoxFit.fill,
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Name: ${cubit.creditsResponse!.cast![index].name ?? ""}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2),
                                                    SizedBox(height: 11),
                                                    Text(
                                                      "Character: ${cubit.creditsResponse!.cast![index].character ?? ""}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 8),
                                      itemCount: 6,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Genres",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cubit
                                          .movieDetailsResponse!.genres!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 11,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 2.3,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 9, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).focusColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            cubit.movieDetailsResponse!
                                                    .genres![index].name! ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
