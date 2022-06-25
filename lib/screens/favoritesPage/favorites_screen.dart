import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../../models/country.dart';
import '../../models/genre.dart';
import '../../services/movie_service.dart';
import '../detailsPage/detail_screen.dart';
import '../mainPage/widgets/home_appbar_widget.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Genre> genres;
  final List<Code> countryCodes;
  const FavoritesScreen(this.genres, this.countryCodes, {Key? key})
      : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreen();
}

class _FavoritesScreen extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 3;
    final double itemWidth = size.width / 2;
    var favMovies = Provider.of<MovieProvider>(context).favoriteMovies;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 5, right: 5),
          child: GridView.builder(
              itemCount: favMovies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              itemBuilder: (context, i) {
                var genreNames = MovieService()
                    .getGenreNames(favMovies[i].genreIds, widget.genres);

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(favMovies[i], genreNames);
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: '${favMovies[i].id}',
                        transitionOnUserGestures: true,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: favMovies[i].posterPath != null
                                  ? NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/${favMovies[i].posterPath}')
                                  : const AssetImage(
                                          'assets/images/no_image_found.jpg')
                                      as ImageProvider,
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
        HomeAppbarWidget("Movies to watch", widget.countryCodes)
      ],
    );
  }
}
