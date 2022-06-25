import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/services/movie_service.dart';

import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _upcomingMovies = [];
  List<Movie> _nowPlayingMovies = [];
  final List<Movie> _favoriteMovies = [];

  List<Movie> get upcomingMovies {
    return [..._upcomingMovies];
  }

  List<Movie> get nowPlayingMovies {
    return [..._nowPlayingMovies];
  }

  List<Movie> get favoriteMovies {
    return [..._favoriteMovies];
  }

  Future<void> fecthAndSetUpcomingMovies(String? code) async {
    log("Fetch and set upcoming movies method called");
    var movies = await MovieService().getUpcomingMovies(code!);
    _upcomingMovies = movies;
    notifyListeners();
  }

  Future<void> fecthAndSetNowPlayingMovies(String? code) async {
    log("Fetch and set now playing movies method called");
    var movies = await MovieService().getMovies(code!);
    _nowPlayingMovies = movies;
    notifyListeners();
  }

  Future<void> fetchAndSetFavoriteMovies(
      Future<List<FavoriteData>> favoriteMovies) async {
    log("Fetch and set favorite movies method called.");

    for (var favMovie in await favoriteMovies) {
      var movie = Movie(
        id: favMovie.movieId,
        originalTitle: favMovie.originalTitle,
        overview: favMovie.overview,
        releaseDate: favMovie.releaseDate,
        popularity: favMovie.popularity,
        genreIds: json.decode(favMovie.genreIds).cast<int>(),
        voteAverage: favMovie.voteAverage,
        posterPath: favMovie.posterPath,
      );
      _favoriteMovies.add(movie);
    }
  }

  Future<void> deleteFavoriteMovie(Movie movie) async {
    for (int i = 0; i < _favoriteMovies.length; i++) {
      if (_favoriteMovies[i].id == movie.id) {
        _favoriteMovies.removeAt(i);
        log("Favorite movie has been deleted.");
        notifyListeners();
        break;
      }
    }
  }

  Future<void> addToFavoriteMovies(Movie movie) async {
    for (var m in _favoriteMovies) {
      if (m.id == movie.id) {
        break;
      }
    }
    _favoriteMovies.add(movie);
    log("Favorite movie added.");
    notifyListeners();
  }

  bool isExistsFavoriteMovie(int movieId) {
    bool existingItem = false;
    try {
      _favoriteMovies.firstWhere((element) => element.id == movieId);
      existingItem = true;
    } on StateError {
      existingItem = false;
    }
    return existingItem;
  }
}
