import 'package:flutter/material.dart';
import 'package:movies_clicks/modules/homepage/model/movie_details.models.dart';

class MovieProductionCountries extends StatelessWidget {
  const MovieProductionCountries(
      {super.key, required this.movieProductionCountries});
  final List<ProductionCountries> movieProductionCountries;
  @override
  Widget build(BuildContext context) {
    if (movieProductionCountries.isEmpty) {
      return const Text('NA');
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: movieProductionCountries
            .map((countries) => Text(countries.name))
            .toList(),
      ),
    );
  }
}
