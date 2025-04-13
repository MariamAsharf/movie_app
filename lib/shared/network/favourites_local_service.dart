import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:movie_app/Model/movie.dart';
import 'package:movie_app/shared/network/cache_network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesLocalService {
  static Future<String> _getBoxName() async {
    final token = CacheNetwork.getCacheData(key: "token");
    return 'favouritesBox_$token';
  }

  static Future<void> addToFavourites(Movie movie) async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<Movie>(boxName);
    await box.put(movie.movieId, movie);
  }

  static Future<List<Movie>> getFavourites() async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<Movie>(boxName);
    return box.values.toList();
  }

  static Future<void> removeFromFavourites(String movieId) async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<Movie>(boxName);
    await box.delete(movieId);
  }

  static Future<void> removeFromFavouritesById(int movieId) async {
    var box = await Hive.openBox<Movie>('favouritesBox');
    final keyToRemove = box.keys.firstWhere(
      (key) => box.get(key)?.movieId == movieId,
      orElse: () => null,
    );
    if (keyToRemove != null) {
      await box.delete(keyToRemove);
    }
  }

  static Future<void> addToHistory(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];

    history.removeWhere(
        (element) => jsonDecode(element)['movieId'] == movie.movieId);

    history.insert(0, jsonEncode(movie.toJson()));
    await prefs.setStringList('history', history);
  }

  static Future<List<Movie>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];

    return history
        .map((movieJson) => Movie.fromJson(jsonDecode(movieJson)))
        .toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
  }

  static Future<bool> isFavourite(String movieId) async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<Movie>(boxName);
    return box.containsKey(movieId);
  }
}
