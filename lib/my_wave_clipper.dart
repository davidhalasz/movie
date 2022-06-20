import 'package:flutter/material.dart';

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
