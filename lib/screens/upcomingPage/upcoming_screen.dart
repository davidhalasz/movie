import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../../models/country.dart';
import '../../models/genre.dart';
import '../../models/movie.dart';
import '../mainPage/widgets/home_appbar_widget.dart';
import '../mainPage/widgets/movie_card_widget.dart';

class UpcominScreen extends StatefulWidget {
  final List<Genre> genres;
  final List<Code> countryCodes;

  const UpcominScreen(this.genres, this.countryCodes, {Key? key})
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

  Future<List<Movie>> _getUpcomingMovies() async {
    var movies = Provider.of<MovieProvider>(context).upcomingMovies;
    return movies;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.90;
    var movies = Provider.of<MovieProvider>(context).upcomingMovies;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Movie>>(
          future: _getUpcomingMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Movie> upcomingMovies = snapshot.data!;

            return Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ListView.builder(
                    itemCount: upcomingMovies.length,
                    itemBuilder: (context, index) {
                      var genreNames =
                          getGenreNames(upcomingMovies[index].genreIds);
                      var movie = upcomingMovies[index];

                      return MovieCardWidget(
                        movie: movie,
                        genreNames: genreNames,
                        screenWidth: screenWidth,
                      );
                    },
                  ),
                ),
                HomeAppbarWidget("Upcoming Movies", widget.countryCodes),
              ],
            );
          }),
    );
  }
}
