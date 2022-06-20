import 'dart:convert';

//List<Genre> genreFromJson(String str) =>
//    List<Genre>.from(json.decode(str).map((x) => Genre.fromJson(x)));

List<Genre> genreFromJson(List str) {
  List<Genre> genres = str.map((i) => Genre.fromJson(i)).toList();
  return genres;
}

String genreToJson(List<Genre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
