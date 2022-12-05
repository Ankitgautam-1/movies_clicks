import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:movies_clicks/modules/homepage/widgets/movies_list.widget.dart';
import 'package:movies_clicks/modules/homepage/widgets/movies_pagination.dart';
import 'package:movies_clicks/modules/homepage/widgets/popular_movies_list.widgets.dart';
import 'package:movies_clicks/modules/internet/internet_bloc.dart';
import 'package:movies_clicks/modules/movie_details/screens/movie_details.screens.dart';

class HomepagePage extends StatefulWidget {
  const HomepagePage({super.key});

  @override
  State<HomepagePage> createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage>
    with AutomaticKeepAliveClientMixin<HomepagePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Movies Clicks",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          
        ),
        body: SizedBox(
          child: ScrollConfiguration(
            behavior: MyScrollBehavior(),
            child: SingleChildScrollView(
              child: BlocConsumer<InternetBloc, InternetState>(
                listenWhen: (previous, current) {
                  if (previous is InternetInitial && current is Connected) {
                    return false;
                  }
                  if (previous is InternetInitial && current is Disconnected) {
                    return true;
                  }
                  if (previous is Connected && current is Disconnected) {
                    return true;
                  }
                  if (previous is Disconnected && current is Connected) {
                    return true;
                  }
                  return false;
                },
                listener: ((context, state) {
                  debugPrint("$state");
                  if (state is Disconnected) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          dismissDirection: DismissDirection.none,
                          duration: Duration(days: 1),
                          behavior: SnackBarBehavior.fixed,
                          content: Text(
                            'No internet connection.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                  }

                  if (state is Connected) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Back Online',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                  }
                }),
                builder: ((context, state) {
                  if (state is Disconnected) {
                    return const Center(
                      child: Text('NO internet connectio'),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: const Text(
                            "Top Upcoming",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Responsive(
                            mobile: SizedBox(height: 450, child: MoviesList()),
                            tablet: SizedBox(height: 500, child: MoviesList()),
                            desktop:
                                SizedBox(height: 700, child: MoviesList())),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: const Text(
                            "Top Rated",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Responsive(
                            mobile:
                                SizedBox(height: 250, child: MovieListPage()),
                            tablet:
                                SizedBox(height: 400, child: MovieListPage()),
                            desktop:
                                SizedBox(height: 400, child: MovieListPage())),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: const Text(
                            "Popular Movies",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Responsive(
                            mobile: SizedBox(
                                height: 250, child: PopularMovieList()),
                            tablet: SizedBox(
                                height: 400, child: PopularMovieList()),
                            desktop: SizedBox(
                                height: 400, child: PopularMovieList())),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        // Container(
                        //   height: 100,
                        //   color: Colors.deepPurple,
                        //   child: const Text("Movie category"),
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 10),
                        // ),
                        // _buildMyList(context),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 10),
                        // ),
                        // _buildPopularList(context),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ));
  }

  _buildMyList(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: Text(
                  "My List",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
              )
            ],
          ),
        ),
        Container(
          height: 300,
          color: Colors.deepPurple,
          child: const Text("MovieListView"),
        )
      ],
    );
  }

  _buildPopularList(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Text(
                    "Popular on Netflix",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                )
              ],
            ),
          ),
          Container(
            height: 300,
            color: Colors.deepPurple,
            child: const Text("MovieListView"),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
