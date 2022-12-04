import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_data_cubit.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';
import 'package:movies_clicks/modules/homepage/repo/movies.repository.dart';

part 'movie_paginated_state.dart';

class MoviePaginatedCubit extends Cubit<MoviePaginatedState> {
  MoviePaginatedCubit({required this.movieRepository})
      : super(MoviePaginatedInitial());
  int page = 1;
  final MovieRepository movieRepository;

  void fetchMore(MoviesListType listType) async {
    if (state is MoviePaginatedDataLoading) return;
    if (state is MoviePaginatedDataLoaded) {
      final currentState = state as MoviePaginatedDataLoaded;

      if (currentState.fetchingMore) {
        return;
      } else {
        if (currentState.page == currentState.moviesData.totalPages) {
          return emit(MoviePaginatedDataLoaded(
              moviesData: currentState.moviesData,
              isLastFetch: true,
              page: currentState.page,
              fetchingMore: true));
        }
        final page = currentState.page + 1;
        emit(MoviePaginatedDataLoaded(
            moviesData: currentState.moviesData,
            isLastFetch: false,
            page: currentState.page,
            fetchingMore: true));
        try {
          final moviePaginatedData = await movieRepository.moviesApiProvider
              .fetchMovieList(listType, page: page);
          currentState.moviesData.movie.addAll(moviePaginatedData.movie);
          debugPrint('currentState: ${currentState.moviesData.movie.length}');
          emit(
            MoviePaginatedDataLoaded(
                moviesData: currentState.moviesData,
                isLastFetch: page == moviePaginatedData.totalPages,
                page: moviePaginatedData.page,
                fetchingMore: false),
          );
        } catch (e) {
          emit(MoviePaginatedFaild(
              oldmoviesData: currentState.moviesData.movie));
        }
      }
    }
    debugPrint('fteching');
  }

  void loadMovieData(
      {required BuildContext context, required MoviesListType type}) async {
    debugPrint("loadMovieData");
    if (state is MoviePaginatedDataLoading) return;
    var oldMoviesData = <Movie>[];
    if (state is MoviePaginatedDataLoading) {
      final currentState = state as MoviePaginatedDataLoaded;
      oldMoviesData = currentState.moviesData.movie;
    }
    emit(MoviePaginatedDataLoading(
      isFirstFetch: page == 1,
      oldmoviesData: oldMoviesData,
    ));

    movieRepository.moviesApiProvider
        .fetchMovieList(type)
        .then((moviesData) async {
      page++;
      try {
        final imageToLoad = getMoviesImagesList(moviesData.movie);
        await Future.wait(
            imageToLoad.map((url) => cachedImage(context: context, url: url)));
        if (moviesData.page == moviesData.totalPages) {
          emit(MoviePaginatedDataLoaded(
              page: 1,
              moviesData: moviesData,
              isLastFetch: true,
              fetchingMore: false));
        } else {
          emit(MoviePaginatedDataLoaded(
              page: 1,
              moviesData: moviesData,
              isLastFetch: false,
              fetchingMore: false));
        }
      } catch (e) {
        debugPrint("error :");
        debugPrint(e.toString());
        emit(const MoviePaginatedFaild(oldmoviesData: []));
      }
    }).onError((error, stackTrace) {
      debugPrint("error :$error");
      debugPrint("stackTrace :$stackTrace");

      emit(MoviePaginatedFaild(oldmoviesData: oldMoviesData));
    });
  }
}

List<String> getMoviesImagesList(List<Movie> movies) {
  return movies.map((movie) => imageBasePath + movie.posterPath).toList();
}

Future cachedImage({required BuildContext context, required String url}) =>
    precacheImage(CachedNetworkImageProvider(url), context);
