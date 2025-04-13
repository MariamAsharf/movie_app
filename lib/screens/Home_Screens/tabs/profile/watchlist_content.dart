import 'package:flutter/material.dart';
import 'package:movie_app/Model/movie.dart';
import 'package:movie_app/screens/Home_Screens/movie_details/movie_details_screen.dart';
import 'package:movie_app/shared/network/favourites_local_service.dart';

class WatchlistContent extends StatefulWidget {
  WatchlistContent({super.key});

  @override
  State<WatchlistContent> createState() => _WatchlistContentState();
}

class _WatchlistContentState extends State<WatchlistContent> {
  late Future<List<Movie>> favourites;

  @override
  void initState() {
    super.initState();
    favourites = FavouritesLocalService.getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: favourites,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No favourite movies added."));
        } else {
          final movies = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
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
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "${movie.imageURL}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 10,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${movie.rating.toStringAsFixed(1)}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.star,
                                  color: Theme.of(context).primaryColor,
                                  size: 15),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 10,
                        child: InkWell(
                          onTap: () async {
                            await FavouritesLocalService.removeFromFavourites(
                                "${movie.movieId}");
                            setState(() {
                              favourites = FavouritesLocalService.getFavourites();
                            });
                          },
                          child: Icon(Icons.delete, color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
