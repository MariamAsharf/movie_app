import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Model/credits_response.dart';
import 'package:movie_app/Model/source_response.dart';
import 'package:movie_app/authentication/auth_cupit.dart';
//import 'package:movie_app/authentication/auth_cubit.dart';
import 'package:movie_app/authentication/auth_states.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String routeName = "Movie Details";
  final int movieId;

  MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.white),
        actions: [Icon(Icons.save, color: Colors.white)],
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is ApiFailedStates) {
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
          if (state is ApiLoadingStates) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ApiSuccessStates) {
            print("Data Type: ${state.data.runtimeType}");
           // print(SourceResponse.Results);
            final movieDetails = state.data;

            final creditsResponse = state.data ;
            final firstThreeCast = creditsResponse.cast?.take(3).toList() ?? [];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieDetails.title ?? "Unknown Title",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 14),
                    Text("Summary", style: Theme.of(context).textTheme.titleSmall),
                    Text(
                      movieDetails['overview'] ?? 'No overview available',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 14),
                    Text("Cast", style: Theme.of(context).textTheme.titleSmall),
                    Column(

                      children: firstThreeCast.map((member) {
                        return Card(
                          color: Theme.of(context).focusColor,
                          child: ListTile(
                            leading: member.profilePath != null
                                ? Image.network(
                              "https://image.tmdb.org/t/p/w500${member.profilePath}",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                                : Icon(Icons.account_circle, size: 40, color: Colors.white),
                            title: Text(member.name ?? "Unknown",
                                style: Theme.of(context).textTheme.titleSmall),
                            subtitle: Text(
                              "Character: ${member.character ?? "Unknown"}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 14),
                    Text("Genres", style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: 8),
                    movieDetails['genres'] != null && movieDetails['genres'].isNotEmpty
                        ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: movieDetails['genres'].map<Widget>((genre) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).focusColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(genre['name'] ?? "Unknown",
                                  style: Theme.of(context).textTheme.titleSmall),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                        : Text("No genres available", style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text("Something went wrong", style: Theme.of(context).textTheme.titleSmall),
            );
          }
        },
      ),
    );
  }
}
