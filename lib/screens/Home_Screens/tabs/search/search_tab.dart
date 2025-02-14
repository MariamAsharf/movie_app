import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';

import '../../movie_details/movie_details_screen.dart';

class SearchTab extends StatelessWidget {
  SearchTab({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MoviesCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            onChanged: (input) {
              cubit.getSearchItem(input: input);
            },
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: Theme.of(context).textTheme.titleSmall,
              prefixIcon: Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: Theme.of(context).focusColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<MoviesCubit, MoviesStates>(
              builder: (context, state) {
                if (state is SourceLoadingStates) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is SearchSuccessStates && cubit.searchItem.isNotEmpty) {
                  return GridView.builder(
                    itemCount: cubit.searchItem.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      final movie = cubit.searchItem[index];
                      return GestureDetector(
                        onTap: () {
                          print("🔍 Navigating from SearchTab to MovieDetailsScreen with ID: ${movie.id}");
                          if (movie.id != null) {
                            Navigator.pushNamed(
                              context,
                              MovieDetailsScreen.routeName,
                              arguments: movie.id,
                            );
                          } else {
                            print("⚠️ Error: Movie ID is null");
                          }
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
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      movie.voteAverage?.toStringAsFixed(1) ?? '0.0',
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.star, color: Theme.of(context).primaryColor, size: 15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Image.asset("assets/images/Empty 1.png"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
