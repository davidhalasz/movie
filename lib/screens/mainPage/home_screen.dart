import 'package:flutter/material.dart';
import 'package:movies/bottom_navbar.dart';
import 'package:movies/services/movie_service.dart';

import '../../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Movie>? _movies = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _movies = (await MovieService().getMovies());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 130,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: MyWaveClipper(),
          child: Container(
            height: 200,
            color: Colors.red,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "In Theaters",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _movies == null || _movies!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView.builder(
                  itemCount: _movies!.length,
                  itemBuilder: (context, index) {
                    return Align(
                      child: SizedBox(
                        width: screenWidth,
                        height: 150,
                        child: Card(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${_movies?[index].posterPath}'),
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
                                    _movies![index].originalTitle,
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
                    );
                  }),
            ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class MyWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var w = size.width;
    var h = size.height;

    path.moveTo(0, h - 20);
    path.lineTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h - 40);

    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            100,
            size.width - ((i + 1) * size.width / 8),
            size.height - 40);
      } else {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            size.height,
            size.width - ((i + 1) * size.width / 8),
            size.height - 40);
      }
    }

    path.lineTo(0.0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
