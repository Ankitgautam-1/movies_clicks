import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_clicks/modules/homepage/model/movie_genres.model.dart';
import 'package:movies_clicks/modules/homepage/repo/movies.repository.dart';

part 'movie_genres_state.dart';

class MovieGenresCubit extends Cubit<MovieGenresState> {
  MovieGenresCubit({required this.movieRepository})
      : super(MovieGenresInitial());
  final MovieRepository movieRepository;
  void loadGenresOfMovie() async {
    if (state is MovieGenresLoading) return;
    emit(MovieGenresLoading());
    try {
      final movieGenres = await movieRepository.fetchMovieGenres();
      emit(MovieGenresLoaded(movieGenres: movieGenres));
    } catch (e) {
      emit(MovieGenresFaild(error: e.toString()));
    }
  }
}
