part of 'movies_photos_cubit.dart';

abstract class MoviesPhotosState extends Equatable {
  const MoviesPhotosState();

  @override
  List<Object> get props => [];
}

class MoviesPhotosInitial extends MoviesPhotosState {}

class MoviesPhotosLoading extends MoviesPhotosState {
  final bool isLoading;
  const MoviesPhotosLoading({required this.isLoading});
}

class MoviesPhotosLoaded extends MoviesPhotosState {
  final List<String> cachedNetworkImage;
  final bool isLoading;
  const MoviesPhotosLoaded(
      {required this.cachedNetworkImage, required this.isLoading});
}

class MoviePhotosFaild extends MoviesPhotosState {
  final String error;

  const MoviePhotosFaild({required this.error});
}
