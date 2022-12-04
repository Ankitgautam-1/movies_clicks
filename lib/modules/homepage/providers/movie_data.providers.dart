import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show Client;
import 'package:movies_clicks/modules/homepage/model/movie_details.models.dart';
import 'package:movies_clicks/modules/homepage/model/movie_genres.model.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = dotenv.get('TMDB_API_KEY');

  Future<MoviesData> fetchMovieList(MoviesListType listType,
      {int page = 1}) async {
    final type = getMovieType(listType);
    debugPrint('type: ${type}');
    try {
      Uri uri = Uri(
          scheme: 'https',
          host: "api.themoviedb.org",
          path: '3/movie/$type',
          query: "api_key=$_apiKey&page=$page");
      debugPrint('uri $uri');
      final response = await client.get(uri);
      inspect(response);
      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return MoviesData.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('e $e');
      rethrow;
    }
  }

  Future<MovieDetailsModel> fetchMovieDetails(int movieID) async {
    debugPrint('movieID: $movieID');
    try {
      Uri uri = Uri(
          scheme: 'https',
          host: "api.themoviedb.org",
          path: '3/movie/$movieID',
          query: "api_key=$_apiKey");
      debugPrint('uri $uri');
      final response = await client.get(uri);
      inspect(response);
      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return MovieDetailsModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('e $e');
      rethrow;
    }
  }

  Future<MovieGenres> fetchMovieGenres() async {
    try {
      Uri uri = Uri(
          scheme: 'https',
          host: "api.themoviedb.org",
          path: '3/genre/movie/list',
          query: "api_key=$_apiKey");
      debugPrint('uri $uri');
      final response = await client.get(uri);
      inspect(response);
      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return MovieGenres.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('e $e');
      rethrow;
    }
  }
}

String getMovieType(MoviesListType type) {
  switch (type) {
    case MoviesListType.nowPlaying:
      {
        return "now_playing";
      }
    case MoviesListType.upcoming:
      {
        return "upcoming";
      }
    case MoviesListType.topRated:
      {
        return "top_rated";
      }
    case MoviesListType.popular:
      {
        return 'popular';
      }

    default:
      {
        return "now_playing";
      }
  }
}
