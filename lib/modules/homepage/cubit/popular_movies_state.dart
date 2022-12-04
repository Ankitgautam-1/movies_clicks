part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesDataLoaded extends PopularMoviesState {
  final MoviesData moviesData;
  final bool isLastFetch;
  final int page;
  final bool fetchingMore;
  const PopularMoviesDataLoaded(
      {required this.moviesData,
      required this.isLastFetch,
      required this.page,
      required this.fetchingMore});

  @override
  List<Object> get props => [moviesData, isLastFetch, page, fetchingMore];
}

class PopularMoviesDataLoading extends PopularMoviesState {
  final List<Movie> oldmoviesData;
  final bool isFirstFetch;

  const PopularMoviesDataLoading({
    required this.isFirstFetch,
    required this.oldmoviesData,
  });
  @override
  List<Object> get props => [oldmoviesData, isFirstFetch];
}

class PopularMoviesFaild extends PopularMoviesState {
  final List<Movie> oldmoviesData;
  const PopularMoviesFaild({
    required this.oldmoviesData,
  });
  @override
  List<Object> get props => [oldmoviesData];
}

class PopularMoviesFetchingMore extends PopularMoviesState {
  final List<Movie> oldmoviesData;
  const PopularMoviesFetchingMore({
    required this.oldmoviesData,
  });
  @override
  List<Object> get props => [oldmoviesData];
}
