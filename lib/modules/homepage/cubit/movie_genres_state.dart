part of 'movie_genres_cubit.dart';

abstract class MovieGenresState extends Equatable {
  const MovieGenresState();

  @override
  List<Object> get props => [];
}

class MovieGenresInitial extends MovieGenresState {}

class MovieGenresLoading extends MovieGenresState {}

class MovieGenresLoaded extends MovieGenresState {
  final MovieGenres movieGenres;
  const MovieGenresLoaded({required this.movieGenres});
}

class MovieGenresFaild extends MovieGenresState {
  final String error;
  const MovieGenresFaild({required this.error});
}
