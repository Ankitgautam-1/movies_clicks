import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:movies_clicks/modules/homepage/cubit/movie_paginated_cubit.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';
import 'package:movies_clicks/modules/homepage/widgets/loading.widgets.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(handleScrollerController);
  }

  void handleScrollerController() {
    if (mounted) {
      if (_scrollController.position.atEdge && _scrollController.offset > 0) {
        debugPrint("fetching more:");

        BlocProvider.of<MoviePaginatedCubit>(context, listen: false)
            .fetchMore(MoviesListType.topRated);
        final state =
            BlocProvider.of<MoviePaginatedCubit>(context, listen: false).state;
        if (state is MoviePaginatedDataLoaded && state.fetchingMore) {
          _scrollController.jumpTo(_scrollController.offset + 160);
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(handleScrollerController);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoviePaginatedCubit>(context)
        .loadMovieData(context: context, type: MoviesListType.topRated);
    return BlocBuilder<MoviePaginatedCubit, MoviePaginatedState>(
        builder: (context, state) {
      if (state is MoviePaginatedDataLoading) {
        return const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Responsive(
              desktop: MoviePaginatedLoadingForDesktop(),
              mobile: MoviePaginatedLoadingForMobile(),
              tablet: MoviePaginatedLoadingForTablet(),
            ));
      }
      if (state is MoviePaginatedFaild) {
        return Text(state.oldmoviesData.toString());
      }
      if (state is MoviePaginatedDataLoaded) {
        final movies = state.moviesData.movie;
        final imageBasePath = dotenv.get('TMDB_IMAGE_BASE_URL_DESKTOP');
        return ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Responsive(
                  mobile: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BuildTopratedMovieListForMobile(
                          imageBasePath: imageBasePath,
                          index: index,
                          movies: movies),
                    ],
                  ),
                  tablet: BuildTopratedMovieListForTablet(
                      imageBasePath: imageBasePath,
                      index: index,
                      movies: movies),
                  desktop: BuildTopratedMovieListForDesktop(
                      imageBasePath: imageBasePath,
                      index: index,
                      movies: movies));
            },
            separatorBuilder: (context, index) {
              return const Responsive(
                mobile: SizedBox(
                  width: 20,
                ),
                tablet: SizedBox(
                  width: 25,
                ),
                desktop: SizedBox(
                  width: 30,
                ),
              );
            },
            itemCount: movies.length);
      }
      return const SizedBox();
    });
  }
}

class BuildTopratedMovieListForMobile extends StatelessWidget {
  const BuildTopratedMovieListForMobile(
      {Key? key,
      required this.imageBasePath,
      required this.movies,
      required this.index})
      : super(key: key);

  final String imageBasePath;
  final List<Movie> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    final movie = movies[index];
    return GestureDetector(
      onTap: () {
        debugPrint("selected movie is ${movie.title}");
        GoRouter.of(context).pushNamed('MovieDeatails',
            params: {'movie_id': movie.id.toString()}, extra: {'movie': movie});
      },
      child: Hero(
        tag: movie.id.toString(),
        child: Container(
          width: 400,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: CachedNetworkImageProvider(
                  imageBasePath + movie.backdropPath,
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
                      border: Border.all(width: 0, color: Colors.transparent),
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
                        margin: const EdgeInsets.only(right: 5),
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
                              fontSize: 13,
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
  }
}

class BuildTopratedMovieListForTablet extends StatelessWidget {
  const BuildTopratedMovieListForTablet(
      {Key? key,
      required this.imageBasePath,
      required this.movies,
      required this.index})
      : super(key: key);

  final String imageBasePath;
  final List<Movie> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    final movie = movies[index];
    return GestureDetector(
      onTap: () {
        debugPrint("selected movie is ${movie.title}");
        GoRouter.of(context).pushNamed('MovieDeatails',
            params: {'movie_id': movie.id.toString()}, extra: {'movie': movie});
      },
      child: Hero(
        tag: movie.id.toString(),
        child: Container(
          width: 500,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: CachedNetworkImageProvider(
                  imageBasePath + movie.backdropPath,
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
                      border: Border.all(width: 0, color: Colors.transparent),
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
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amber,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        Center(
                          child: Text(
                            movie.voteAverage.toString(),
                            style: const TextStyle(
                              fontSize: 17,
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
  }
}

class BuildTopratedMovieListForDesktop extends StatelessWidget {
  const BuildTopratedMovieListForDesktop(
      {Key? key,
      required this.imageBasePath,
      required this.movies,
      required this.index})
      : super(key: key);

  final String imageBasePath;
  final List<Movie> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    final movie = movies[index];
    return GestureDetector(
      onTap: () {
        debugPrint("selected movie is ${movie.title}");
        GoRouter.of(context).pushNamed('MovieDeatails',
            params: {'movie_id': movie.id.toString()}, extra: {'movie': movie});
      },
      child: Hero(
        tag: movie.id.toString(),
        child: Container(
          width: 700,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: CachedNetworkImageProvider(
                  imageBasePath + movie.backdropPath,
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
                      border: Border.all(width: 0, color: Colors.transparent),
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
  }
}
