part of 'movie_paginated_cubit.dart';

abstract class MoviePaginatedState extends Equatable {
  const MoviePaginatedState();

  @override
  List<Object> get props => [];
}

class MoviePaginatedInitial extends MoviePaginatedState {}

class MoviePaginatedDataLoaded extends MoviePaginatedState {
  final MoviesData moviesData;
  final bool isLastFetch;
  final int page;
  final bool fetchingMore;
  const MoviePaginatedDataLoaded(
      {required this.moviesData,
      required this.isLastFetch,
      required this.page,
      required this.fetchingMore});

  @override
  List<Object> get props => [moviesData, isLastFetch, page, fetchingMore];
}

class MoviePaginatedDataLoading extends MoviePaginatedState {
  final List<Movie> oldmoviesData;
  final bool isFirstFetch;

  const MoviePaginatedDataLoading({
    required this.isFirstFetch,
    required this.oldmoviesData,
  });
  @override
  List<Object> get props => [oldmoviesData, isFirstFetch];
}

class MoviePaginatedFaild extends MoviePaginatedState {
  final List<Movie> oldmoviesData;
  const MoviePaginatedFaild({
    required this.oldmoviesData,
  });
  @override
  List<Object> get props => [oldmoviesData];
}

class MoviePaginatedFetchingMore extends MoviePaginatedState {
  final List<Movie> oldmoviesData;
  const MoviePaginatedFetchingMore({
    required this.oldmoviesData,
  });
  @override
  List<Object> get props => [oldmoviesData];
}
