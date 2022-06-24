import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../../../models/movie.dart';

class WatchlistWidget extends StatefulWidget {
  final Movie movie;
  final bool isFavorite;
  const WatchlistWidget(
    this.movie,
    this.isFavorite, {
    Key? key,
  }) : super(key: key);

  @override
  State<WatchlistWidget> createState() => _WatchlistWidgetState();
}

class _WatchlistWidgetState extends State<WatchlistWidget> {
  late bool addedMovie;
  @override
  void initState() {
    super.initState();
    addedMovie = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addToWatchlist(Movie movie) async {
      bool isExists = await Provider.of<AppDb>(context, listen: false)
          .isExistsFavoriteMovie(movie.id);
      if (!isExists) {
        final entity = FavoriteCompanion(
          movieId: drift.Value(movie.id),
          originalTitle: drift.Value(movie.originalTitle),
          posterPath: drift.Value(movie.posterPath),
          overview: drift.Value(movie.overview),
          releaseDate: drift.Value(movie.releaseDate),
          popularity: drift.Value(movie.popularity.toDouble()),
          genreIds: drift.Value(movie.genreIds.toString()),
          voteAverage: drift.Value(movie.voteAverage.toDouble()),
        );
        await Provider.of<AppDb>(context, listen: false)
            .insertFavorite(entity)
            .then((_) {
          setState(() {
            addedMovie = true;
            Provider.of<MovieProvider>(context, listen: false)
                .addToFavoriteMovies(movie);
          });
        });
      } else {
        log("Movie exists on favorite list.");
      }
    }

    Future<void> deleteFromWatchlist(Movie movie) async {
      await Provider.of<AppDb>(context, listen: false)
          .deleteFavoriteByMovieId(movie.id)
          .then((_) {
        setState(() {
          addedMovie = false;
          Provider.of<MovieProvider>(context, listen: false)
              .deleteFavoriteMovie(movie);
        });
      });
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.black.withOpacity(0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 190),
              child: addedMovie
                  ? GestureDetector(
                      onTap: () => deleteFromWatchlist(widget.movie),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            "Added to My Watchlist",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () => addToWatchlist(widget.movie),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            "Add to My Watchlist",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
