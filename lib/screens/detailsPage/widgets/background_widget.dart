import 'package:flutter/material.dart';

import '../../../models/movie.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Hero(
          tag: '${movie.id}',
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
          ),
        ),
      ),
    );
  }
}
