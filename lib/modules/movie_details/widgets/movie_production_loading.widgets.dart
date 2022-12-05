import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieProductionLoading extends StatelessWidget {
  const MovieProductionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerPro.sized(
                scaffoldBackgroundColor: Colors.grey.shade600,
                height: 80,
                width: 140),
            ShimmerPro.sized(
                scaffoldBackgroundColor: Colors.grey.shade600,
                height: 80,
                width: 140),
            ShimmerPro.sized(
                scaffoldBackgroundColor: Colors.grey.shade600,
                height: 80,
                width: 140),
            ShimmerPro.sized(
                scaffoldBackgroundColor: Colors.grey.shade600,
                height: 80,
                width: 140),
          ],
        ),
      ),
    );
  }
}
