import 'dart:convert';
import 'dart:developer';

import 'package:movies/constants/apiConstant.dart';
import 'package:movies/models/movie.dart';

import 'package:http/http.dart' as http;

class MovieService {
  Future<List<Movie>?> getMovies() async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.nowPlaying}${ApiConstants.apiKey}&language=en-US&page=1&region=hu");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['results'] as List;
        var _movies = movieFromJson(data);
        return _movies;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
