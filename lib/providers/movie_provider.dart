import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movies/services/movie_service.dart';

import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _upcomingMovies = [];
  List<Movie> _nowPlayingMovies = [];

  List<Movie> get upcomingMovies {
    return [..._upcomingMovies];
  }

  List<Movie> get nowPlayingMovies {
    return [..._nowPlayingMovies];
  }

  Future<void> fecthAndSetUpcomingMovies(String? code) async {
    log("Fetch and set upcoming movies method started");
    var movies = await MovieService().getUpcomingMovies(code!);
    _upcomingMovies = movies;
    notifyListeners();
  }

  Future<void> fecthAndSetNowPlayingMovies(String? code) async {
    log("Fetch and set now playing movies method started");
    var movies = await MovieService().getMovies(code!);
    _nowPlayingMovies = movies;
    notifyListeners();
  }
}
