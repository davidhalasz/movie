import 'package:flutter/material.dart';
import 'package:movies/constants/style_constants.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({
    Key? key,
    required this.genreNames,
  }) : super(key: key);

  final List<String> genreNames;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.black.withOpacity(0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Genres",
                      style: TextStyle(
                          color: Colors.white, fontSize: detailWidgetTitle),
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var name in genreNames)
                          Text(
                            name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
