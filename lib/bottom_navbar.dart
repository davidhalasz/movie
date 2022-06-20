import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.theaters,
            color: Colors.red,
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
    );
  }
}
