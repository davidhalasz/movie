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
      child: Align(
        child: SizedBox(
          width: screenWidth,
          height: 150,
          child: Card(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Hero(
              tag: '${movie.id}',
              transitionOnUserGestures: true,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: movie.posterPath != null
                        ? NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}')
                        : const AssetImage('assets/images/no_image_found.jpg')
                            as ImageProvider,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
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
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
