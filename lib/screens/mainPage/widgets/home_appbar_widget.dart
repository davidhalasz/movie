import 'package:flutter/material.dart';
import 'package:movies/constants/style_constants.dart';

import '../../../my_wave_clipper.dart';

class HomeAppbarWidget extends StatelessWidget {
  final String title;
  const HomeAppbarWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: ClipPath(
        clipper: MyWaveClipper(),
        child: Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: appbarTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ),
    );
  }
}
