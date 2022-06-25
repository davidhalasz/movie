import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../detailsPage/detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    Key? key,
    required this.movie,
    required this.genreNames,
    required this.screenWidth,
  }) : super(key: key);

  final Movie movie;
  final List<String> genreNames;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailScreen(movie, genreNames);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Align(
          child: SizedBox(
            width: screenWidth,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Hero(
                tag: '${movie.id}',
                transitionOnUserGestures: true,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage(
                        width: double.infinity,
                        placeholder: const AssetImage(
                            'assets/images/film_countdown.gif'),
                        image: movie.posterPath != null
                            ? NetworkImage(
                                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                              )
                            : const AssetImage(
                                    'assets/images/no_image_found.jpg')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [
                              0.5,
                              0.9,
                            ],
                            colors: [
                              Colors.indigo.withOpacity(0.4),
                              Colors.teal.withOpacity(0.4),
                            ],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            movie.originalTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
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
