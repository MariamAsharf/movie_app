import 'package:flutter/material.dart';
import 'package:movie_app/Model/movie.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details_screen.dart';
import 'package:movie_app/shared/network/favourites_local_service.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  late Future<List<Movie>> history;

  @override
  void initState() {
    super.initState();
    history = FavouritesLocalService.getHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Viewing History",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton.icon(
                onPressed: () async {
                  await FavouritesLocalService.clearHistory();
                  setState(() {
                    history = FavouritesLocalService.getHistory();
                  });
                },
                icon: Icon(Icons.delete_outline, color: Colors.red),
                label: Text(
                  "Clear",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Movie>>(
            future: history,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No viewing history."));
              }

              final movies = snapshot.data!;
              return GridView.builder(
                itemCount: movies.length,
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MovieDetailsScreen.routeName,
                        arguments: int.parse(movie.movieId),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        movie.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
