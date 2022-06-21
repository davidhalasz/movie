import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:movies/constants/api_constant.dart';
import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';
import '../models/genre.dart';

class MovieService {
  Future<List<Movie>?> getMovies(String region) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.nowPlaying}${ApiConstants.apiKey}&language=en-US&page=1&region=$region");
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

  Future<List<Movie>?> getUpcomingMovies(String region) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.upcoming}${ApiConstants.apiKey}&language=en-US&region=$region");
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

  Future<List<Code>> getCountryCodes() async {
    List<Code> codes = [];
    try {
      var response = await loadAsset('assets/data/countries.json');
      var data = jsonDecode(response) as Map<String, dynamic>;
      codes = codeFromJson(data);
    } catch (e) {
      log(e.toString());
    }
    return codes;
  }

  Future<String> loadAsset(String filename) async {
    return await rootBundle.loadString(filename);
  }
}
