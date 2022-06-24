import 'package:flutter/material.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/favoritesPage/favorites_screen.dart';
import 'package:movies/screens/nowPlayingPage/now_playing_screen.dart';
import 'package:movies/screens/upcomingPage/upcoming_screen.dart';
import 'package:provider/provider.dart';

import '../../models/country.dart';
import '../../models/genre.dart';
import '../../services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Genre> _genres = [];
  late List<Code> _countryCodes = [];
  late String currentCountryCode = "";
  final PageController _controller = PageController(initialPage: 0);
  Duration pageChanging = const Duration(milliseconds: 300);
  Curve animationCurve = Curves.linear;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    _genres = await MovieService().getGenres();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    _countryCodes = await MovieService().getCountryCodes();
    await Provider.of<AppDb>(context, listen: false).getCountry().then((value) {
      currentCountryCode = value.code;
      Provider.of<MovieProvider>(context, listen: false)
          .fecthAndSetNowPlayingMovies(value.code);
      Provider.of<MovieProvider>(context, listen: false)
          .fecthAndSetUpcomingMovies(value.code);
      var favoriteMovies =
          Provider.of<AppDb>(context, listen: false).getFavorites();
      Provider.of<MovieProvider>(context, listen: false)
          .fetchAndSetFavoriteMovies(favoriteMovies);
    });
  }

  void navigationTapped(int page) {
    _controller.animateToPage(
      page,
      duration: pageChanging,
      curve: animationCurve,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onPageChanged(int page) {
    if (mounted) {
      setState(() {
        _page = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        onPageChanged: onPageChanged,
        children: [
          NowPlayingScreen(_genres, _countryCodes),
          UpcominScreen(_genres, _countryCodes),
          FavoritesScreen(_genres, _countryCodes),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.theaters,
            ),
            label: "Now Playing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: "Upcoming",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
        onTap: navigationTapped,
        selectedItemColor: Colors.red,
        currentIndex: _page,
      ),
    );
  }
}
