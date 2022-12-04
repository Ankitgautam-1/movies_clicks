class MovieGenres {
  final List<Genres>? genres;

  MovieGenres({
    required this.genres,
  });

  MovieGenres copyWith({
    List<Genres>? genres,
  }) {
    return MovieGenres(
      genres: genres ?? this.genres,
    );
  }

  MovieGenres.fromJson(Map<String, dynamic> json)
      : genres = (json['genres'] as List?)
            ?.map((dynamic e) => Genres.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'genres': genres?.map((e) => e.toJson()).toList()};
}

class Genres {
  final int? id;
  final String? name;

  Genres({
    this.id,
    this.name,
  });

  Genres copyWith({
    int? id,
    String? name,
  }) {
    return Genres(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Genres.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
