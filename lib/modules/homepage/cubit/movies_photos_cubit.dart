import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'movies_photos_state.dart';

class MoviesPhotosCubit extends Cubit<MoviesPhotosState> {
  MoviesPhotosCubit() : super(MoviesPhotosInitial());
  Future<void> loadMovieImage(
      {required List<String> imageToLoad,
      required BuildContext context}) async {
    emit(const MoviesPhotosLoading(isLoading: true));
    try {
      await Future.wait(
          imageToLoad.map((url) => cachedImage(context: context, url: url)));
      emit(MoviesPhotosLoaded(
          cachedNetworkImage: imageToLoad, isLoading: false));
    } catch (e) {
      emit(const MoviePhotosFaild(error: "something went wrong"));
    }
  }
}

Future cachedImage({required BuildContext context, required String url}) =>
    precacheImage(CachedNetworkImageProvider(url), context);
