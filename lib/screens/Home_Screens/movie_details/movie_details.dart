import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Blocs/movies_cubit.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/model/movie_details_response.dart';
import 'package:movie_app/model/images_response.dart';
import 'package:movie_app/model/credits_response.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = "Movie Details";
  final int movieId;
  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          if (state is SourceLoadingStates) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SourceSuccessStates) {
            final movie = state.data.movies;
            final images = state.data.images;
            final credits = state.data.credits;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMoviePoster(movie),
                    _buildMovieInfo(movie),
                    _buildWatchButton(),
                    _buildMovieStats(movie),
                    _buildSectionTitle("Screen Shots"),
                    _buildScreenshots(images),
                    _buildSectionTitle("Similar Movies"),
                    _buildSimilarMovies(movie.similarMovies ?? []),
                    _buildSectionTitle("Summary"),
                    _buildMovieOverview(movie),
                    _buildSectionTitle("Cast"),
                    _buildCastList(credits),
                    _buildSectionTitle("Genres"),
                    _buildGenres(movie),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("Failed to load movie details"));
          }
        },
      ),
    );
  }

  Widget _buildMoviePoster(MovieDetailsResponse movie) {
    return Stack(
      children: [
        movie.posterPath != null
            ? Image.network(
                movie.posterPath!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 400,
              )
            : Container(height: 400, color: Colors.black),
        Positioned(
          top: 20,
          left: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfo(MovieDetailsResponse movie) {
    return Column(
      children: [
        Text(
          movie.title ?? "Unknown",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          movie.releaseDate ?? "Unknown Release Date",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildWatchButton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Watch", style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildMovieStats(MovieDetailsResponse movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem(Icons.favorite, movie.voteCount?.toString() ?? "0"),
        _buildStatItem(Icons.access_time, "${movie.runtime ?? 0} min"),
        _buildStatItem(Icons.star, movie.voteAverage?.toStringAsFixed(1) ?? "0.0"),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildScreenshots(ImagesResponse images) {
    if (images.backdrops == null || images.backdrops!.isEmpty) {
      return const Center(child: Text("No images available", style: TextStyle(color: Colors.white)));
    }
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.backdrops!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.network(images.backdrops![index].filePath!, width: 200, height: 150),
          );
        },
      ),
    );
  }

  Widget _buildSimilarMovies(List<MovieDetailsResponse> movies) {
    if (movies.isEmpty) {
      return const Center(child: Text("No similar movies found", style: TextStyle(color: Colors.white)));
    }
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Image.network(movies[index].posterPath!, width: 150, height: 200),
                Text(movies[index].title ?? "Unknown", style: const TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieOverview(MovieDetailsResponse movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        movie.overview ?? "No overview available",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCastList(CreditsResponse credits) {
    if (credits.cast == null || credits.cast!.isEmpty) {
      return const Center(child: Text("No cast available", style: TextStyle(color: Colors.white)));
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: credits.cast!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(credits.cast![index].profilePath!), radius: 40),
              Text(credits.cast![index].name ?? "Unknown", style: const TextStyle(color: Colors.white)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGenres(MovieDetailsResponse movie) {
    if (movie.genres == null || movie.genres!.isEmpty) {
      return const Center(child: Text("No genres available", style: TextStyle(color: Colors.white)));
    }
    return Wrap(
      spacing: 8,
      children: movie.genres!.map((genre) => Chip(label: Text(genre.name ?? "Unknown"))).toList(),
    );
  }
}
