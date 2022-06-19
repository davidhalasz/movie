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
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${_movies?[index].posterPath}'),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            child: Center(
                                child: Text(
                              _movies![index].originalTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )),
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
