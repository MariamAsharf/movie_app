import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Blocs/movies_cubit.dart';
import '../../../Blocs/movies_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "Movie Details";

  MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MoviesCubit>(context);
    return BlocProvider(
      create: (context) => MoviesCubit(),
      child: BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {
          if (state is SourceLoadingStates) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is FailedToSourceStates) {
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
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w500${cubit.movieDetailsResponse?.posterPath}",
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
