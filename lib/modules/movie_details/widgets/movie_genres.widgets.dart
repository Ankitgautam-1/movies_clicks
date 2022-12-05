import 'package:flutter/material.dart';
import 'package:movies_clicks/modules/homepage/model/movie_genres.model.dart';

List<Container> buildGenres(List<Genres> genres) => genres
    .map(
      (genre) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          genre.name.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    )
    .toList();
