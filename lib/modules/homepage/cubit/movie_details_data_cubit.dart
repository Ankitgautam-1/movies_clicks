import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_clicks/modules/homepage/model/movie_details.models.dart';
import 'package:movies_clicks/modules/homepage/repo/movies.repository.dart';

part 'movie_details_data_state.dart';

class MovieDetailsDataCubit extends Cubit<MovieDetailsDataState> {
  MovieDetailsDataCubit({required this.movieRepository})
      : super(MovieDetailsDataInitial());
  final MovieRepository movieRepository;
  void loadMovieDetails(int movieID) async {
    if (state is MovieDetailsDataLoading) return;
    emit(MovieDetailsDataLoading());
    try {
      final movieDetails = await movieRepository.fetchMovieDetail(movieID);
      emit(MovieDetailsDataLoaded(movieDetails: movieDetails));
    } catch (e) {
      emit(const MovieDetailsDataFaild(error: "Something went wrong"));
    }
  }
}
