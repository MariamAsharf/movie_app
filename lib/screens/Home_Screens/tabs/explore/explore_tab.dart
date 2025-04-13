import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';

import '../../movie_details/movie_details_screen.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {
        if (state is SourceLoadingStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Loading movies...")),
          );
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<MoviesCubit>(context);

        if (cubit.genres.isEmpty) {
          cubit.getGenres();
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16),
              SizedBox(
                height: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.genres.length,
                  itemBuilder: (context, index) {
                    final genre = cubit.genres[index];
                    bool isSelected = cubit.selectedGenreId == genre.id;

                    return GestureDetector(
                      onTap: () {
                        cubit.getMoviesByGenre(genre.id!);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: Text(genre.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: isSelected
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor
                                        : Theme.of(context).primaryColor)),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                ),
              ),
              SizedBox(height: 22),
              Expanded(
                child: state is SourceLoadingStates
                    ? Center(child: CircularProgressIndicator())
                    : cubit.filteredMovies.isEmpty
                        ? Center(child: Text("No movies available"))
                        : GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: cubit.filteredMovies.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              final movie = cubit.filteredMovies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MovieDetailsScreen.routeName,
                                    arguments: movie.id,
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      left: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
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
                                                color: Theme.of(context)
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
            ],
          ),
        );
      },
    );
  }
}
