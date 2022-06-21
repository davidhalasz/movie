import 'package:flutter/material.dart';

import '../../data/db/app_db.dart';
import '../../models/country.dart';
import '../../models/genre.dart';
import '../../models/movie.dart';
import '../mainPage/widgets/home_appbar_widget.dart';
import '../mainPage/widgets/movie_card_widget.dart';

class UpcominScreen extends StatefulWidget {
  final List<Movie>? movies;
  final List<Genre> genres;
  final List<Code> countryCodes;
  final AppDb db;
  const UpcominScreen(this.movies, this.genres, this.countryCodes, this.db,
      {Key? key})
      : super(key: key);

  @override
  State<UpcominScreen> createState() => _UpcominScreenState();
}

class _UpcominScreenState extends State<UpcominScreen> {
  List<String> getGenreNames(List<int> genreIds) {
    List<String> names = [];
    if (widget.genres.isNotEmpty) {
      for (var id in genreIds) {
        for (int t = 0; t < widget.genres.length; t++) {
          if (id == widget.genres[t].id) {
            names.add(widget.genres[t].name);
            break;
          }
        }
      }
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.90;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: widget.movies == null || widget.movies!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ListView.builder(
                    itemCount: widget.movies!.length,
                    itemBuilder: (context, index) {
                      var genreNames =
                          getGenreNames(widget.movies![index].genreIds);
                      var movie = widget.movies![index];

                      return MovieCardWidget(
                        movie: movie,
                        genreNames: genreNames,
                        screenWidth: screenWidth,
                      );
                    },
                  ),
                ),
                HomeAppbarWidget(
                    "Upcoming Movies", widget.countryCodes, widget.db),
              ],
            ),
    );
  }
}
