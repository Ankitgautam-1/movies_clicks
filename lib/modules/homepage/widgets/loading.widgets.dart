import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MoviePaginatedLoadingForMobile extends StatelessWidget {
  const MoviePaginatedLoadingForMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 400),
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 400),
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 400)
      ],
    );
  }
}

class MoviePaginatedLoadingForTablet extends StatelessWidget {
  const MoviePaginatedLoadingForTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 600),
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 600),
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 600)
      ],
    );
  }
}

class MoviePaginatedLoadingForDesktop extends StatelessWidget {
  const MoviePaginatedLoadingForDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 700),
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 700),
        ShimmerPro.sized(
            height: double.infinity,
            scaffoldBackgroundColor: Colors.grey.shade600,
            width: 700)
      ],
    );
  }
}
