import 'dart:convert';
import 'dart:developer';

import 'package:movies/constants/api_constant.dart';
import 'package:movies/models/movie.dart';

import 'package:http/http.dart' as http;

import '../models/genre.dart';

class MovieService {
  Future<List<Movie>?> getMovies() async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.nowPlaying}${ApiConstants.apiKey}&language=en-US&page=1&region=hu");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['results'] as List;
        var movies = movieFromJson(data);
        return movies;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Genre>> getGenres() async {
    List<Genre> genres = [];
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.genres}${ApiConstants.apiKey}&language=en-US");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['genres'] as List;
        genres = genreFromJson(data);
        return genres;
      }
    } catch (e) {
      log(e.toString());
    }
    return genres;
  }
}
