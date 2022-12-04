import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_clicks/modules/homepage/repo/movies.repository.dart';

import '../model/movies_data.models.dart';

part 'movie_data_state.dart';

final imageBasePath = dotenv.get('TMDB_IMAGE_BASE_URL');

class MovieDataCubit extends Cubit<MovieDataState> {
  MovieDataCubit({required this.movieRepository}) : super(MovieDataInitial());
  int page = 1;
  final MovieRepository movieRepository;
  void loadMovieData(
      {required BuildContext context, required MoviesListType type}) async {
    debugPrint("loadMovieData");
    if (state is MovieDataLoading) return;
    var oldMoviesData = <Movie>[];
    if (state is MovieDataLoaded) {
      final currentState = state as MovieDataLoaded;
      oldMoviesData = currentState.moviesData.movie;
    }
    emit(MovieDataLoading(
        isFirstFetch: page == 1, oldmoviesData: oldMoviesData));

    movieRepository.moviesApiProvider
        .fetchMovieList(type)
        .then((moviesData) async {
      page++;
      try {
        final imageToLoad = getMoviesImagesList(moviesData.movie);
        await Future.wait(
            imageToLoad.map((url) => cachedImage(context: context, url: url)));
        emit(MovieDataLoaded(moviesData: moviesData));
      } catch (e) {
        emit(const MovieDataFaild(oldmoviesData: []));
      }
    }).onError((error, stackTrace) {
      emit(MovieDataFaild(oldmoviesData: oldMoviesData));
    });
  }
}

List<String> getMoviesImagesList(List<Movie> movies) {
  return movies.map((movie) => imageBasePath + movie.posterPath).toList();
}

Future cachedImage({required BuildContext context, required String url}) =>
    precacheImage(CachedNetworkImageProvider(url), context);
