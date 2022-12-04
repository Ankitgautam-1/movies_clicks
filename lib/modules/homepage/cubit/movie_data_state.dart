part of 'movie_data_cubit.dart';

abstract class MovieDataState extends Equatable {
  const MovieDataState();

  @override
  List<Object> get props => [];
}

class MovieDataInitial extends MovieDataState {}

class MovieDataLoaded extends MovieDataState {
  final MoviesData moviesData;
  const MovieDataLoaded({required this.moviesData});

  @override
  List<Object> get props => [moviesData];
}

class MovieDataLoading extends MovieDataState {
  final List<Movie> oldmoviesData;
  final bool isFirstFetch;
  const MovieDataLoading(
      {required this.isFirstFetch, required this.oldmoviesData});
}

class MovieDataFaild extends MovieDataState {
  final List<Movie> oldmoviesData;
  const MovieDataFaild({
    required this.oldmoviesData,
  });
}
