import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieGenreLoading extends StatelessWidget {
  const MovieGenreLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.generated(
      scaffoldBackgroundColor: Colors.transparent,
      child: Row(
        children: [
          ShimmerPro.generated(
            light: ShimmerProLight.lighter,
            depth: 30,
            scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
            borderRadius: 25,
            height: 30,
            width: 80,
            alignment: Alignment.centerLeft,
            child: ShimmerPro.sized(
              light: ShimmerProLight.lighter,
              scaffoldBackgroundColor: Colors.grey.shade700,
              height: 20,
              width: 50,
            ),
          ),
          ShimmerPro.generated(
            light: ShimmerProLight.lighter,
            depth: 30,
            scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
            borderRadius: 25,
            height: 30,
            width: 80,
            alignment: Alignment.centerLeft,
            child: ShimmerPro.sized(
              light: ShimmerProLight.lighter,
              scaffoldBackgroundColor: Colors.grey.shade700,
              height: 20,
              width: 50,
            ),
          ),
          ShimmerPro.generated(
            light: ShimmerProLight.lighter,
            depth: 30,
            scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
            borderRadius: 25,
            height: 30,
            width: 80,
            alignment: Alignment.centerLeft,
            child: ShimmerPro.sized(
              light: ShimmerProLight.lighter,
              scaffoldBackgroundColor: Colors.grey.shade700,
              height: 20,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
