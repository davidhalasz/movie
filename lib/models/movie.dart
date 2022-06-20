import 'dart:convert';

List<Movie> movieFromJson(List str) {
  List<Movie> imagesList = str.map((i) => Movie.fromJson(i)).toList();
  return imagesList;
}

String movieToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  Movie({
    required this.id,
    required this.originalTitle,
    this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.popularity,
    required this.genreIds,
    required this.voteAverage,
  });

  int id;
  String originalTitle;
  String? posterPath;
  String overview;
  String releaseDate;
  num popularity;
  List<int> genreIds;
  num voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<int> genreIdsList = [];
    for (int i = 0; i < json['genre_ids'].length; i++) {
      genreIdsList.add(json['genre_ids'][i]);
    }
    return Movie(
      id: json["id"],
      originalTitle: json["original_title"],
      posterPath: json["poster_path"],
      overview: json["overview"],
      releaseDate: json["release_date"],
      popularity: json["popularity"],
      genreIds: genreIdsList,
      voteAverage: json["vote_average"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "release_date": releaseDate,
        "popularity": popularity,
        "genre_id": genreIds,
        "vote_average": voteAverage,
      };
}
