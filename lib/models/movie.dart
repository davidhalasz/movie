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
  });

  int id;
  String originalTitle;
  String? posterPath;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_title": originalTitle,
        "poster_path": posterPath,
      };
}
