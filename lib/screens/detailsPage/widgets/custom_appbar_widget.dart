import 'package:flutter/material.dart';
import 'package:movies/constants/style_constants.dart';

import '../../../my_wave_clipper.dart';
import '../../../models/movie.dart';

class CustomAppbarWidget extends StatelessWidget {
  const CustomAppbarWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: ClipPath(
        clipper: MyWaveClipper(),
        child: Container(
          color: Colors.transparent.withOpacity(0.6),
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      movie.originalTitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: appbarTitleSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
