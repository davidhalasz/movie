import 'package:flutter/material.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/screens/nowPlayingPage/now_playing_screen.dart';
import 'package:movies/screens/upcomingPage/upcoming_screen.dart';
import 'package:drift/drift.dart' as drift;

import '../../models/country.dart';
import '../../models/genre.dart';
import '../../models/movie.dart';
import '../../services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppDb _db;
  late List<Movie>? _movies = [];
  late List<Movie>? _upcomingMovies = [];
  late List<Genre> _genres = [];
  late List<Code> _countryCodes = [];
  final PageController _controller = PageController(initialPage: 0);
  Duration pageChanging = const Duration(
      milliseconds: 300); //this is for page animation-not necessary
  Curve animationCurve =
      Curves.linear; //this is for page animation-not necessary
  int _page = 0;
  String currentCountryCode = "HU";

  @override
  void initState() {
    super.initState();
    _getData();
    _db = AppDb();
    _insertToEmptyTable();
  }

  Future<void> _insertToEmptyTable() async {
    bool isEmpty = await _db.isEmptyTable();
    if (isEmpty) {
      const entity = CountryCompanion(
          id: drift.Value(1),
          code: drift.Value("HU"),
          name: drift.Value("Hungary"));
      await _db.insertCountry(entity);
    }
  }

  Future<void> getCurrentCode() async {
    await _db.getCountry().then((value) {
      setState(() {
        currentCountryCode = value.code;
      });
    });
  }

  Future<void> _getData() async {
    _movies = await MovieService().getMovies(currentCountryCode);
    _genres = await MovieService().getGenres();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    _upcomingMovies =
        await MovieService().getUpcomingMovies(currentCountryCode);
    _countryCodes = await MovieService().getCountryCodes();
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
    _db.close();
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
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: onPageChanged,
        children: [
          NowPlayingScreen(_movies, _genres, _countryCodes, _db),
          UpcominScreen(_upcomingMovies, _genres, _countryCodes, _db),
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
            label: "bus",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "school",
          ),
        ],
        onTap: navigationTapped,
        selectedItemColor: Colors.red,
        currentIndex: _page,
      ),
    );
  }
}
