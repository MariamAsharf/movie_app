import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final String movieId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double rating;
  @HiveField(3)
  final String imageURL;
  @HiveField(4)
  final String year;

  Movie({
    required this.movieId,
    required this.name,
    required this.rating,
    required this.imageURL,
    required this.year,
  });

  // لتحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'name': name,
      'rating': rating,
      'imageURL': imageURL,
      'year': year,
    };
  }

  // لتحويل JSON إلى كائن Movie
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieId: json['movieId'],
      name: json['name'],
      rating: json['rating'].toDouble(),
      imageURL: json['imageURL'],
      year: json['year'],
    );
  }
}
