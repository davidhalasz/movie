import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/detailsPage/widgets/watchlist_widget.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import 'widgets/background_widget.dart';
import 'widgets/custom_appbar_widget.dart';
import 'widgets/genres_widget.dart';
import 'widgets/overview_widget.dart';
import 'widgets/popularity_widget.dart';
import 'widgets/release_date_widget.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  final List<String> genreNames;

  const DetailScreen(this.movie, this.genreNames, {Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _changeOpacity();
  }

  void _changeOpacity() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // yyyy-mm-dd
    var dateFormatted = DateFormat("dd-MMMM-yyyy")
        .format(DateTime.parse(widget.movie.releaseDate));
    var date = dateFormatted.split("-");
    var isFavorite = Provider.of<MovieProvider>(context)
        .isExistsFavoriteMovie(widget.movie.id);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              BackgroundWidget(movie: widget.movie),
              AnimatedOpacity(
                curve: Curves.linear,
                duration: const Duration(seconds: 1),
                opacity: opacityLevel,
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Wrap(
                    children: [
                      WatchlistWidget(widget.movie, isFavorite),
                      ReleaseDateWidget(date: date),
                      GenresWidget(genreNames: widget.genreNames),
                      PopularityWidget(movie: widget.movie),
                      OverviewWidget(movie: widget.movie),
                    ],
                  ),
                ),
              ),
              CustomAppbarWidget(movie: widget.movie),
            ],
          ),
        ),
      ),
    );
  }
}
