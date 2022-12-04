import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_data_cubit.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_details_data_cubit.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_genres_cubit.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_paginated_cubit.dart';
import 'package:movies_clicks/modules/homepage/cubit/popular_movies_cubit.dart';
import 'package:movies_clicks/modules/homepage/model/movie_genres.model.dart';
import 'package:movies_clicks/modules/homepage/repo/movies.repository.dart';
import 'package:movies_clicks/modules/internet/internet_bloc.dart';
import 'common_export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await SharedPrefs.instance.init();
  final MovieRepository movieRepository = MovieRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UpdateThemeBloc>(
          create: (BuildContext context) => UpdateThemeBloc(),
        ),
        BlocProvider<InternetBloc>(
          create: (BuildContext context) => InternetBloc(),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                MovieDataCubit(movieRepository: movieRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                MovieDetailsDataCubit(movieRepository: movieRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                MovieGenresCubit(movieRepository: movieRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                MoviePaginatedCubit(movieRepository: movieRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                PopularMoviesCubit(movieRepository: movieRepository)),
      ],
      child: const App(),
    ),
  );
}
