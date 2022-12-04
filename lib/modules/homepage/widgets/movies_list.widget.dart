import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_genres_cubit.dart';
import 'package:movies_clicks/modules/homepage/widgets/movie_loading.widgets.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_data_cubit.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovieDataCubit>(context)
        .loadMovieData(context: context, type: MoviesListType.nowPlaying);
    BlocProvider.of<MovieGenresCubit>(context).loadGenresOfMovie();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<MovieDataCubit, MovieDataState>(
        builder: (context, state) {
          if (state is MovieDataLoading && state.isFirstFetch) {
            return Stack(
              children: const <Widget>[
                Positioned.fill(
                  top: 0,
                  bottom: 0,
                  right: -60,
                  left: -240,
                  child: MovieListShimmer(),
                ),
              ],
            );
          }
          List<Movie> currentMovie = <Movie>[];
          if (state is MovieDataLoading && !state.isFirstFetch) {
            currentMovie = state.oldmoviesData;
          } else if (state is MovieDataLoaded) {
            currentMovie = state.moviesData.movie;
          }
          return Responsive(
              mobile: buildCarouselForMobile(currentMovie),
              tablet: buildCarouselForTablet(currentMovie),
              desktop: buildCarouselForDesktop(currentMovie));
        },
      ),
    );
  }
}

Widget buildCarouselForDesktop(List<Movie> currentMovie) {
  return CarouselSlider(
    options: CarouselOptions(
        autoPlay: true,
        pageSnapping: true,
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.linearToEaseOut,
        clipBehavior: Clip.antiAlias),
    items: currentMovie.map((movie) {
      return Builder(
        builder: (BuildContext context) {
          final imageUrlBase = dotenv.get('TMDB_IMAGE_BASE_URL_DESKTOP');
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed('MovieDeatails',
                  params: {'movie_id': movie.id.toString()},
                  extra: {'movie': movie});
            },
            child: Hero(
              tag: movie.id.toString(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: CachedNetworkImageProvider(
                        imageUrlBase + movie.backdropPath,
                      ),
                    ),
                    border: Border.all(width: 0, color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
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
                                  Colors.black.withOpacity(1)
                                ],
                                stops: const [
                                  0.0,
                                  0.6,
                                  1.0
                                ]),
                            border:
                                Border.all(width: 0, color: Colors.transparent),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: movie.adult ? 1 : 0,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Center(
                                child: Text(
                                  "18+",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 24,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                                size: 40,
                              ),
                              const SizedBox(width: 5),
                              Center(
                                child: Text(
                                  movie.voteAverage.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}

Widget buildCarouselForTablet(List<Movie> currentMovie) {
  return CarouselSlider(
    options: CarouselOptions(
        height: 900.0,
        aspectRatio: 9 / 16,
        autoPlay: true,
        pageSnapping: true,
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.linearToEaseOut,
        clipBehavior: Clip.antiAlias),
    items: currentMovie.map((movie) {
      return Builder(
        builder: (BuildContext context) {
          final imageUrlBase = dotenv.get('TMDB_IMAGE_BASE_URL_DESKTOP');
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed('MovieDeatails',
                  params: {'movie_id': movie.id.toString()},
                  extra: {'movie': movie});
            },
            child: Hero(
              tag: movie.id.toString(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 600,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: CachedNetworkImageProvider(
                        imageUrlBase + movie.backdropPath,
                      ),
                    ),
                    border: Border.all(width: 0, color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
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
                                Colors.black.withOpacity(1)
                              ],
                              stops: const [
                                0.0,
                                0.6,
                                1.0
                              ]),
                          border:
                              Border.all(width: 0, color: Colors.transparent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                    )),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: movie.adult ? 1 : 0,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Center(
                                child: Text(
                                  "18+",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                                size: 25,
                              ),
                              const SizedBox(width: 5),
                              Center(
                                  child: Text(
                                movie.voteAverage.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}

Widget buildCarouselForMobile(List<Movie> currentMovie) {
  return CarouselSlider(
    options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        pageSnapping: true,
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.linearToEaseOut,
        clipBehavior: Clip.antiAlias),
    items: currentMovie.map((movie) {
      return Builder(
        builder: (BuildContext context) {
          final imageUrlBase = dotenv.get('TMDB_IMAGE_BASE_URL_DESKTOP');
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed('MovieDeatails',
                  params: {'movie_id': movie.id.toString()},
                  extra: {'movie': movie});
            },
            child: Hero(
              tag: movie.id.toString(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: CachedNetworkImageProvider(
                        imageUrlBase + movie.posterPath,
                      ),
                    ),
                    border: Border.all(width: 0, color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
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
                                Colors.black.withOpacity(1)
                              ],
                              stops: const [
                                0.0,
                                0.6,
                                1.0
                              ]),
                          border:
                              Border.all(width: 0, color: Colors.transparent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                    )),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: movie.adult ? 1 : 0,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Center(
                                child: Text(
                                  "18+",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                                size: 25,
                              ),
                              const SizedBox(width: 5),
                              Center(
                                child: Text(
                                  movie.voteAverage.toString(),
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}
