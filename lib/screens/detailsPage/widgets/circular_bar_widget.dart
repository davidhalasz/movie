import 'package:flutter/material.dart';

import '../../../models/movie.dart';

class CircularBarWidget extends StatelessWidget {
  const CircularBarWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: movie.voteAverage / 10),
        duration: const Duration(seconds: 2),
        builder: (context, value, child) {
          return Container(
            width: 90,
            height: 90,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const SweepGradient(
                      startAngle: 1.0,
                      endAngle: 3.14 * 2,
                      stops: [0.1, 0.4, 0.6, 1.0],
                      center: Alignment.center,
                      colors: [
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                        Colors.green,
                      ],
                    ).createShader(rect);
                  },
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                      startAngle: 0.0,
                      endAngle: 3.14 * 2,
                      stops: [value as double, value],
                      center: Alignment.center,
                      colors: const [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ).createShader(rect);
                  },
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
