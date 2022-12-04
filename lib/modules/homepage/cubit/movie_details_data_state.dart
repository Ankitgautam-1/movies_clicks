part of 'movie_details_data_cubit.dart';

abstract class MovieDetailsDataState extends Equatable {
  const MovieDetailsDataState();

  @override
  List<Object> get props => [];
}

class MovieDetailsDataInitial extends MovieDetailsDataState {}

class MovieDetailsDataLoading extends MovieDetailsDataState {}

class MovieDetailsDataLoaded extends MovieDetailsDataState {
  final MovieDetailsModel movieDetails;

  const MovieDetailsDataLoaded({required this.movieDetails});
}

class MovieDetailsDataFaild extends MovieDetailsDataState {
  final String error;

  const MovieDetailsDataFaild({required this.error});
}
