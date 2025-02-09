import 'package:flutter/material.dart';
import 'package:movie_app/api_manager.dart';
import 'package:movie_app/model/images_response.dart';
import 'package:movie_app/model/movie_details_response.dart';
import 'package:movie_app/model/source_response.dart';
import 'package:movie_app/model/credits_response.dart';

import '../../../Model/images_response.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName="moviedetails";
  final int movieId;
  MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsResponse>(
      future: ApiManager.getMovieDetails(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        var movieDetails = snapshot.data;
        if (movieDetails == null) {
          return Center(child: Text("No details available"));
        }

        return FutureBuilder<ImagesResponse>(
          future: ApiManager.getMovieImages(widget.movieId),
          builder: (context, imageSnapshot) {
            if (imageSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (imageSnapshot.hasError) {
              return Center(child: Text("Error: ${imageSnapshot.error}"));
            }

            var images = imageSnapshot.data;

            return FutureBuilder<SourceResponse>(
              future: ApiManager.getSources(),
              builder: (context, sourceSnapshot) {
                if (sourceSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (sourceSnapshot.hasError) {
                  return Center(child: Text("Error: ${sourceSnapshot.error}"));
                }

                var data = sourceSnapshot.data?.results;
                if (data == null || data.isEmpty) {
                  return Center(child: Text("No data available"));
                }

                return FutureBuilder<CreditsResponse>(
                  future: ApiManager.getMovieCredits(widget.movieId),
                  builder: (context, creditsSnapshot) {
                    if (creditsSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (creditsSnapshot.hasError) {
                      return Center(child: Text("Error: ${creditsSnapshot.error}"));
                    }

                    var cast = creditsSnapshot.data?.cast;
                    if (cast == null || cast.isEmpty) {
                      return Center(child: Text("No cast available"));
                    }
                    var firstThreeCast = cast.take(4).toList();

                    return SafeArea(
                      child: Scaffold(
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  movieDetails.posterPath != null
                                      ? Align(
                                    alignment: Alignment.center,
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}',
                                      width: 430,
                                      height: 645,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Container(),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(Icons.arrow_back_ios, size: 24.0, color: Colors.white)

                                      ),
                                      Spacer(),
                                      Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.save, size: 24.0, color: Colors.white)

                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 248),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 97,
                                            color: Colors.amber,
                                          ),
                                          Icon(
                                            Icons.circle_outlined,
                                            size: 87,
                                            color: Colors.white,
                                          ),
                                          Icon(
                                            Icons.play_arrow,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 580),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${movieDetails.title}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 610),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${movieDetails.releaseDate}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xffADADAD),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 398,
                                height: 58,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text(
                                    "Watch",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xff282A28),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "${movieDetails.voteCount}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xff282A28),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled_rounded,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "${movieDetails.runtime}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xff282A28),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "${movieDetails.voteAverage?.toStringAsFixed(1) ?? '0.0'}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Screen Shots",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              images != null && images.backdrops != null && images.backdrops!.isNotEmpty
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${images.backdrops![0].filePath}',
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(height: 12),
                              images != null && images.backdrops != null && images.backdrops!.isNotEmpty
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${images.backdrops![1].filePath}',
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(height: 12),
                              images != null && images.backdrops != null && images.backdrops!.isNotEmpty
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${images.backdrops![2].filePath}',
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Similar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  if (data != null && data.length > 2 && data[2].posterPath != null)
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w500${data[2].posterPath}',
                                      width: 189,
                                      height: 279,
                                    )
                                  else
                                    Center(
                                      child: Text(
                                        "No image available",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  SizedBox(width: 15),
                                  if (data != null && data.length > 2 && data[3].posterPath != null)
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w500${data[3].posterPath}',
                                      width: 189,
                                      height: 279,
                                    )
                                  else
                                    Center(
                                      child: Text(
                                        "No image available",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  if (data != null && data.length > 2 && data[4].posterPath != null)
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w500${data[4].posterPath}',
                                      width: 189,
                                      height: 279,
                                    )
                                  else
                                    Center(
                                      child: Text(
                                        "No image available",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  SizedBox(width: 15),
                                  if (data != null && data.length > 2 && data[5].posterPath != null)
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w500${data[5].posterPath}',
                                      width: 189,
                                      height: 279,
                                    )
                                  else
                                    Center(
                                      child: Text(
                                        "No image available",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Summary",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  movieDetails.overview ?? 'No overview available',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                                ),
                              ),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Cast",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              for (var member in firstThreeCast)
                                Card(
                                  color: Color(0xff282A28),
                                  child: Row(
                                    children: [
                                      // تحقق إذا كانت profilePath موجودة
                                      if (member.profilePath != null && member.profilePath!.isNotEmpty)
                                        Image.network(
                                          "https://image.tmdb.org/t/p/w500${member.profilePath}",
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )
                                      else
                                      // إذا كانت الصورة غير متاحة، عرض أيقونة بديلة
                                        Icon(Icons.account_circle, size: 10),
                                      Column(
                                        children: [
                                          Text(
                                            "name:${member.name}",
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "character:${member.character}",
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Genres",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: movieDetails.genres != null && movieDetails.genres!.isNotEmpty
                                    ? SingleChildScrollView(  // إضافة هذه لتصفح العناصر عند امتلاء المساحة
                                  scrollDirection: Axis.horizontal,  // اجعل التمرير أفقيًا
                                  child: Row(
                                    children: movieDetails.genres!.map((genre) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 4),  // لتوفير المسافة بين العناصر
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Color(0xff282A28),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            genre.name ?? "Unknown",
                                            style: TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                                    : Text(
                                  "No genres available",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
