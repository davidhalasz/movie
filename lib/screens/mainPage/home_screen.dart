import 'package:flutter/material.dart';
import 'package:movies/bottom_navbar.dart';
import 'package:movies/services/movie_service.dart';

import '../../models/genre.dart';
import '../../models/movie.dart';
import 'widgets/home_appbar_widget.dart';
import 'widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Movie>? _movies = [];
  late List<Genre> _genres = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _movies = (await MovieService().getMovies());
    _genres = (await MovieService().getGenres());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  List<String> getGenreNames(List<int> genreIds) {
    List<String> names = [];
    if (_genres.isNotEmpty) {
      for (var id in genreIds) {
        for (int t = 0; t < _genres.length; t++) {
          if (id == _genres[t].id) {
            names.add(_genres[t].name);
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

    return Scaffold(
      body: _movies == null || _movies!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: ListView.builder(
                      itemCount: _movies!.length,
                      itemBuilder: (context, index) {
                        var genreNames =
                            getGenreNames(_movies![index].genreIds);
                        var movie = _movies![index];

                        return MovieCardWidget(
                          movie: movie,
                          genreNames: genreNames,
                          screenWidth: screenWidth,
                        );
                      },
                    ),
                  ),
                  const HomeAppbarWidget(),
                ],
              ),
            ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
