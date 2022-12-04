import 'package:flutter/cupertino.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieListShimmer extends StatelessWidget {
  const MovieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const int count = 3;
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Responsive(
                mobile: BuildMovieListLoaderForMobile(
                  index: index,
                ),
                desktop: BuildMovieListLoaderForDesktop(index: index),
                tablet: BuildMovieListLoaderForTablet(index: index),
              ),
          itemCount: count);
    });
  }
}

class BuildMovieListLoaderForDesktop extends StatelessWidget {
  const BuildMovieListLoaderForDesktop({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.sized(
      light: ShimmerProLight.lighter,
      depth: 30,
      scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
      height: double.infinity,
      width: index == 1 ? MediaQuery.of(context).size.width * 0.8 : 400,
    );
  }
}

class BuildMovieListLoaderForTablet extends StatelessWidget {
  const BuildMovieListLoaderForTablet({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.sized(
      light: ShimmerProLight.lighter,
      depth: 30,
      scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
      height: double.infinity,
      width: index == 1 ? MediaQuery.of(context).size.width * 0.7 : 300,
    );
  }
}

class BuildMovieListLoaderForMobile extends StatelessWidget {
  const BuildMovieListLoaderForMobile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.sized(
      light: ShimmerProLight.lighter,
      depth: 30,
      scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
      height: double.infinity,
      width: index == 1 ? MediaQuery.of(context).size.width * 0.75 : 250,
    );
  }
}
