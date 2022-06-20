import 'package:flutter/material.dart';

import '../mainPage/widgets/home_appbar_widget.dart';

class UpcominScreen extends StatefulWidget {
  const UpcominScreen({Key? key}) : super(key: key);

  @override
  State<UpcominScreen> createState() => _UpcominScreenState();
}

class _UpcominScreenState extends State<UpcominScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.90;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.passthrough,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: Text("UPCOMIN FILMS"),
            ),
          ),
          HomeAppbarWidget("Upcoming Movies"),
        ],
      ),
    );
  }
}
