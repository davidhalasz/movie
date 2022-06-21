import 'package:flutter/material.dart';
import 'package:movies/screens/nowPlayingPage/now_playing_screen.dart';
import 'package:movies/screens/upcomingPage/upcomingScreen.dart';

import '../../models/genre.dart';
import '../../models/movie.dart';
import '../../services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Movie>? _movies = [];
  late List<Movie>? _upcomingMovies = [];
  late List<Genre> _genres = [];
  final PageController _controller = PageController(initialPage: 0);
  Duration pageChanging = const Duration(
      milliseconds: 300); //this is for page animation-not necessary
  Curve animationCurve =
      Curves.linear; //this is for page animation-not necessary
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _movies = (await MovieService().getMovies());
    _genres = (await MovieService().getGenres());
    _upcomingMovies = (await MovieService().getUpcomingMovies());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
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
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: onPageChanged,
        children: [
          NowPlayingScreen(_movies, _genres),
          UpcominScreen(_upcomingMovies, _genres),
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
