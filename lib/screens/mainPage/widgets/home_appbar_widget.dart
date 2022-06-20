import 'package:flutter/material.dart';
import 'package:movies/constants/style_constants.dart';

import '../../../custom_app_bar.dart';

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({
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
          child: const Align(
              alignment: Alignment.center,
              child: Text(
                "In Theaters",
                style: TextStyle(
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
