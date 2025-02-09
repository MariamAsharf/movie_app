import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Model/images_response.dart';
import 'model/movie_details_response.dart';
import 'model/source_response.dart';
import 'model/images_response.dart';  // تأكد من استيراد الموديل الخاص بالصور
import 'model/credits_response.dart'; // تأكد من أنك أضفت ملف Model للـ CreditsResponse

class ApiManager {
  static const String _apiKey = 'bc0ab3e0445b44f445c083c4c1957cd4';  // ضع هنا مفتاح الـ API الخاص بك
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  // جلب الأفلام الشائعة
  static Future<SourceResponse> getSources() async {
    try {
      Uri url = Uri.https("api.themoviedb.org", "/3/movie/popular", {
        "api_key": _apiKey,
      });

      http.Response response = await http.get(url);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        SourceResponse sourceResponse = SourceResponse.fromJson(jsonData);
        return sourceResponse;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load sources');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load sources');
    }
  }

  // جلب تفاصيل الفيلم بناءً على movieId
  static Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    try {
      Uri url = Uri.https("api.themoviedb.org", "/3/movie/$movieId", {
        "api_key": _apiKey,
        "language": "en-US",
      });

      http.Response response = await http.get(url);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        MovieDetailsResponse movieDetailsResponse = MovieDetailsResponse.fromJson(jsonData);
        return movieDetailsResponse;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load movie details');
    }
  }

  // جلب صور الفيلم (مشاهد من الفيلم)
  static Future<ImagesResponse> getMovieImages(int movieId) async {
    try {
      Uri url = Uri.https("api.themoviedb.org", "/3/movie/$movieId/images", {
        "api_key": _apiKey,
      });

      http.Response response = await http.get(url);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ImagesResponse.fromJson(jsonResponse);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load movie images');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load movie images');
    }
  }

  // جلب بيانات الطاقم للفيلم
  static Future<CreditsResponse> getMovieCredits(int movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // تحويل الـ JSON إلى كائن CreditsResponse
        return CreditsResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load credits');
      }
    } catch (e) {
      throw Exception('Error fetching movie credits: $e');
    }
  }
}
