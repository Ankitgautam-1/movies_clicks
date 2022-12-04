import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_data_cubit.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';
import 'package:movies_clicks/modules/homepage/repo/movies.repository.dart';
import 'package:movies_clicks/utils/is_path_empty.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit({required this.movieRepository})
      : super(PopularMoviesInitial());
  int page = 1;
  final MovieRepository movieRepository;

  void fetchMore(MoviesListType listType) async {
    if (state is PopularMoviesDataLoading) return;
    if (state is PopularMoviesDataLoaded) {
      final currentState = state as PopularMoviesDataLoaded;

      if (currentState.fetchingMore) {
        return;
      } else {
        if (currentState.page == currentState.moviesData.totalPages) {
          return emit(PopularMoviesDataLoaded(
              moviesData: currentState.moviesData,
              isLastFetch: true,
              page: currentState.page,
              fetchingMore: true));
        }
        final page = currentState.page + 1;
        emit(PopularMoviesDataLoaded(
            moviesData: currentState.moviesData,
            isLastFetch: false,
            page: currentState.page,
            fetchingMore: true));
        try {
          final popularMoviesData = await movieRepository.moviesApiProvider
              .fetchMovieList(listType, page: page);
          currentState.moviesData.movie.addAll(popularMoviesData.movie);
          debugPrint('currentState: ${currentState.moviesData.movie.length}');
          emit(
            PopularMoviesDataLoaded(
                moviesData: currentState.moviesData,
                isLastFetch: page == popularMoviesData.totalPages,
                page: popularMoviesData.page,
                fetchingMore: false),
          );
        } catch (e) {
          emit(
              PopularMoviesFaild(oldmoviesData: currentState.moviesData.movie));
        }
      }
    }
    debugPrint('fteching');
  }

  void loadMovieData(
      {required BuildContext context, required MoviesListType type}) async {
    debugPrint("loadMovieData");
    if (state is PopularMoviesDataLoading) return;
    var oldMoviesData = <Movie>[];
    if (state is PopularMoviesDataLoading) {
      final currentState = state as PopularMoviesDataLoaded;
      oldMoviesData = currentState.moviesData.movie;
    }
    emit(PopularMoviesDataLoading(
      isFirstFetch: page == 1,
      oldmoviesData: oldMoviesData,
    ));

    movieRepository.moviesApiProvider
        .fetchMovieList(type)
        .then((moviesData) async {
      page++;
      try {
        bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
        final imageToLoad = getMoviesImagesList(moviesData.movie, isAndroid);

        await Future.wait(
            imageToLoad.map((url) => cachedImage(context: context, url: url)));
        if (moviesData.page == moviesData.totalPages) {
          emit(PopularMoviesDataLoaded(
              page: 1,
              moviesData: moviesData,
              isLastFetch: true,
              fetchingMore: false));
        } else {
          emit(PopularMoviesDataLoaded(
              page: 1,
              moviesData: moviesData,
              isLastFetch: false,
              fetchingMore: false));
        }
      } catch (e) {
        debugPrint("error :");
        debugPrint(e.toString());
        emit(const PopularMoviesFaild(oldmoviesData: []));
      }
    }).onError((error, stackTrace) {
      debugPrint("error :$error");
      debugPrint("stackTrace :$stackTrace");

      emit(PopularMoviesFaild(oldmoviesData: oldMoviesData));
    });
  }
}

List<String> getMoviesImagesList(List<Movie> movies, bool isAndroid) {
  return movies
      .where((movie) => movie.backdropPath != null)
      .map((movie) => imageBasePath + isPathEmpty(movie.backdropPath))
      .toList();
}

Future cachedImage({required BuildContext context, required String url}) =>
    precacheImage(CachedNetworkImageProvider(url), context);
