import 'package:movies_clicks/modules/homepage/model/movie_details.models.dart';
import 'package:movies_clicks/modules/homepage/model/movie_genres.model.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';
import 'package:movies_clicks/modules/homepage/providers/movie_data.providers.dart';

class MovieRepository {
  final moviesApiProvider = MovieApiProvider();

  Future<MovieDetailsModel> fetchMovieDetail(int movieId) =>
      moviesApiProvider.fetchMovieDetails(movieId);

  Future<MoviesData> fetchMovieList(MoviesListType type) =>
      moviesApiProvider.fetchMovieList(type);

  Future<MovieGenres> fetchMovieGenres() =>
      moviesApiProvider.fetchMovieGenres();
}
