// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:movies_clicks/config/screens_config.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_details_data_cubit.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_genres_cubit.dart';

import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';
import 'package:movies_clicks/modules/homepage/widgets/movie_genres.widget.dart';
import 'package:movies_clicks/modules/movie_details/widgets/movie_genres.widgets.dart';
import 'package:movies_clicks/modules/movie_details/widgets/movie_overview.widget.dart';
import 'package:movies_clicks/modules/movie_details/widgets/movie_production.widgets.dart';
import 'package:movies_clicks/modules/movie_details/widgets/movie_production_loading.widgets.dart';
import 'package:movies_clicks/modules/movie_details/widgets/movies_production_countries.widgets.dart';
import 'package:movies_clicks/utils/is_path_empty.dart';
import 'package:movies_clicks/utils/theme_color_switch.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movie_id, this.movie});
  final int movie_id;
  final Movie? movie;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final bool expanedForMore = false;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovieDetailsDataCubit>(context)
        .loadMovieDetails(widget.movie_id);
    final AppBar appBar = AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)),
    );
    final imageUrlBase = dotenv.get('TMDB_IMAGE_BASE_URL_DESKTOP');
    final imageUrlBaseMobile = dotenv.get('TMDB_IMAGE_BASE_URL');

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Responsive(
            mobile: buildScreenForMobile(
                context: context,
                imageUrlBaseMobile: imageUrlBase,
                movie: widget.movie!),
            desktop: buildScreenForDesktop(
                context: context,
                imageUrlBase: imageUrlBase,
                movie: widget.movie!),
            tablet: buildScreenForTablet(
                context: context,
                imageUrlBase: imageUrlBase,
                movie: widget.movie!),
          ),
        ),
      ),
    );
  }
}

Widget buildScreenForMobile(
    {required BuildContext context,
    required String imageUrlBaseMobile,
    required Movie movie}) {
  return Stack(
    children: [
      Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: movie.id.toString(),
                    child: CachedNetworkImage(
                      imageUrl:
                          imageUrlBaseMobile + isPathEmpty(movie.backdropPath),
                      errorWidget: (context, url, error) {
                        return Image.asset(AllImages().kDefaultImage);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            ColorConstants()
                                .darkBackgroundColor
                                .withOpacity(0.0),
                            ColorConstants()
                                .darkBackgroundColor
                                .withOpacity(0.0),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(1)
                          ],
                          stops: const [
                            0.0,
                            0.5,
                            1.0
                          ]),
                      border: Border.all(width: 0, color: Colors.transparent),
                    ),
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 1.2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      DateFormat("MMM, dd, yyyy").format(movie.releaseDate),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 1.2),
                    ),
                    Container(
                      color: themeColorSwitch(context,
                          darkColor: Colors.grey.shade500,
                          lightColor: Colors.grey.shade800),
                      width: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                    ),
                    Tooltip(
                      message: "IMDB Ratings",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 23,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.voteAverage.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: themeColorSwitch(context,
                          darkColor: Colors.grey.shade500,
                          lightColor: Colors.grey.shade800),
                      width: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                    ),
                    Tooltip(
                      message: "Vote Count",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.how_to_vote_rounded,
                            color: Colors.grey,
                            size: 23,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.voteCount.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                BlocBuilder<MovieGenresCubit, MovieGenresState>(
                  builder: (context, state) {
                    if (state is MovieGenresLoading) {
                      return const MovieGenreLoading();
                    }
                    if (state is MovieGenresLoaded) {
                      final filterGenres =
                          state.movieGenres.genres!.where((ge) {
                        return movie.genreIds.contains(ge.id);
                      }).toList();
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: buildGenres(filterGenres),
                          ),
                        ),
                      );
                    }
                    if (state is MovieGenresFaild) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                MovieOverview(
                  text: movie.overview,
                  minLength: 150,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<MovieDetailsDataCubit, MovieDetailsDataState>(
              builder: (context, state) {
                debugPrint("state $state");
                if (state is MovieDetailsDataLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPro.sized(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        borderRadius: 5,
                        scaffoldBackgroundColor: Colors.grey.shade600,
                        width: 150,
                      ),
                      ShimmerPro.sized(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        borderRadius: 5,
                        scaffoldBackgroundColor: Colors.grey.shade600,
                        width: 50,
                      ),
                      const MovieProductionLoading(),
                    ],
                  );
                }
                if (state is MovieDetailsDataFaild) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (state is MovieDetailsDataLoaded) {
                  final productionCompanies =
                      state.movieDetails.productionCompanies;
                  debugPrint(
                      'productionCompanies: ${productionCompanies.length}');
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.movieDetails.status != "Released"
                            ? Center(
                                child:
                                    Text(state.movieDetails.status.toString()),
                              )
                            : const SizedBox.shrink(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Production Countries",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            MovieProductionCountries(
                              movieProductionCountries:
                                  state.movieDetails.productionCountries,
                            ),
                          ],
                        ),
                        if (productionCompanies.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: MoviePriductionList(
                                productionCompanies: productionCompanies),
                          )
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildScreenForTablet(
    {required BuildContext context,
    required String imageUrlBase,
    required Movie movie}) {
  return Stack(
    children: [
      Column(
        children: <Widget>[
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: movie.id.toString(),
                    child: CachedNetworkImage(
                      imageUrl: imageUrlBase + isPathEmpty(movie.backdropPath),
                      errorWidget: (context, url, error) {
                        return Image.asset(AllImages().kDefaultImage);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            ColorConstants()
                                .darkBackgroundColor
                                .withOpacity(0.0),
                            ColorConstants()
                                .darkBackgroundColor
                                .withOpacity(0.0),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(1)
                          ],
                          stops: const [
                            0.0,
                            0.5,
                            1.0
                          ]),
                      border: Border.all(width: 0, color: Colors.transparent),
                    ),
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      letterSpacing: 1.2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat("MMM, dd, yyyy").format(movie.releaseDate),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 1.2),
                    ),
                    Container(
                      color: themeColorSwitch(context,
                          darkColor: Colors.grey.shade500,
                          lightColor: Colors.grey.shade800),
                      width: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                    ),
                    Tooltip(
                      message: "IMDB Ratings",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.voteAverage.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: themeColorSwitch(context,
                          darkColor: Colors.grey.shade500,
                          lightColor: Colors.grey.shade800),
                      width: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                    ),
                    Tooltip(
                      message: "Vote Count",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.how_to_vote_rounded,
                            color: Colors.grey,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.voteCount.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                BlocBuilder<MovieGenresCubit, MovieGenresState>(
                  builder: (context, state) {
                    if (state is MovieGenresLoading) {
                      return const MovieGenreLoading();
                    }
                    if (state is MovieGenresLoaded) {
                      final filterGenres =
                          state.movieGenres.genres!.where((ge) {
                        return movie.genreIds.contains(ge.id);
                      }).toList();
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: buildGenres(filterGenres),
                          ),
                        ),
                      );
                    }
                    if (state is MovieGenresFaild) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                MovieOverview(
                  text: movie.overview,
                  minLength: 150,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<MovieDetailsDataCubit, MovieDetailsDataState>(
              builder: (context, state) {
                if (state is MovieDetailsDataLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPro.sized(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        borderRadius: 5,
                        scaffoldBackgroundColor: Colors.grey.shade600,
                        width: 150,
                      ),
                      ShimmerPro.sized(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        borderRadius: 5,
                        scaffoldBackgroundColor: Colors.grey.shade600,
                        width: 50,
                      ),
                      const MovieProductionLoading(),
                    ],
                  );
                }
                if (state is MovieDetailsDataFaild) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (state is MovieDetailsDataLoaded) {
                  final productionCompanies =
                      state.movieDetails.productionCompanies;
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.movieDetails.status != "Released"
                            ? Center(
                                child:
                                    Text(state.movieDetails.status.toString()),
                              )
                            : const SizedBox.shrink(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Production Countries",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                                state.movieDetails.productionCountries[0].name),
                          ],
                        ),
                        if (productionCompanies.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: MoviePriductionList(
                                productionCompanies: productionCompanies),
                          )
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildScreenForDesktop(
    {required BuildContext context,
    required String imageUrlBase,
    required Movie movie}) {
  return Stack(
    children: [
      Column(
        children: <Widget>[
          SizedBox(
            height: 700,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: movie.id.toString(),
                    child: CachedNetworkImage(
                      imageUrl: imageUrlBase + isPathEmpty(movie.backdropPath),
                      errorWidget: (context, url, error) {
                        return Image.asset(AllImages().kDefaultImage);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            ColorConstants()
                                .darkBackgroundColor
                                .withOpacity(0.0),
                            ColorConstants()
                                .darkBackgroundColor
                                .withOpacity(0.0),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(1)
                          ],
                          stops: const [
                            0.0,
                            0.5,
                            1.0
                          ]),
                      border: Border.all(width: 0, color: Colors.transparent),
                    ),
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      letterSpacing: 1.2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat("MMM, dd, yyyy").format(movie.releaseDate),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 1.2),
                    ),
                    Container(
                      color: themeColorSwitch(context,
                          darkColor: Colors.grey.shade500,
                          lightColor: Colors.grey.shade800),
                      width: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                    ),
                    Tooltip(
                      message: "IMDB Ratings",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.voteAverage.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: themeColorSwitch(context,
                          darkColor: Colors.grey.shade500,
                          lightColor: Colors.grey.shade800),
                      width: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 30,
                    ),
                    Tooltip(
                      message: "Vote Count",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.how_to_vote_rounded,
                            color: Colors.grey,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.voteCount.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                BlocBuilder<MovieGenresCubit, MovieGenresState>(
                  builder: (context, state) {
                    if (state is MovieGenresLoading) {
                      return const MovieGenreLoading();
                    }
                    if (state is MovieGenresLoaded) {
                      final filterGenres =
                          state.movieGenres.genres!.where((ge) {
                        return movie.genreIds.contains(ge.id);
                      }).toList();
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: buildGenres(filterGenres),
                          ),
                        ),
                      );
                    }
                    if (state is MovieGenresFaild) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                MovieOverview(
                  text: movie.overview,
                  minLength: 150,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<MovieDetailsDataCubit, MovieDetailsDataState>(
              builder: (context, state) {
                if (state is MovieDetailsDataLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPro.sized(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        borderRadius: 5,
                        scaffoldBackgroundColor: Colors.grey.shade600,
                        width: 150,
                      ),
                      ShimmerPro.sized(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        borderRadius: 5,
                        scaffoldBackgroundColor: Colors.grey.shade600,
                        width: 50,
                      ),
                      const MovieProductionLoading(),
                    ],
                  );
                }
                if (state is MovieDetailsDataFaild) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (state is MovieDetailsDataLoaded) {
                  final productionCompanies =
                      state.movieDetails.productionCompanies;
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.movieDetails.status != "Released"
                            ? Center(
                                child:
                                    Text(state.movieDetails.status.toString()),
                              )
                            : const SizedBox.shrink(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Production Countries",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                                state.movieDetails.productionCountries[0].name),
                          ],
                        ),
                        if (productionCompanies.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: MoviePriductionList(
                                productionCompanies: productionCompanies),
                          )
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    ],
  );
}
