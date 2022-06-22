import 'package:flutter/material.dart';
import 'package:movies/constants/style_constants.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/models/country.dart';
import 'package:drift/drift.dart' as drift;
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../../../my_wave_clipper.dart';

class HomeAppbarWidget extends StatefulWidget {
  final String title;
  final List<Code> countryCodes;
  const HomeAppbarWidget(
    this.title,
    this.countryCodes, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeAppbarWidget> createState() => _HomeAppbarWidgetState();
}

class _HomeAppbarWidgetState extends State<HomeAppbarWidget> {
  var currentCountryCode = "HU";

  @override
  void initState() {
    super.initState();
    changeCurrentCode();
  }

  Future<void> changeCurrentCode() async {
    await Provider.of<AppDb>(context, listen: false).getCountry().then((value) {
      setState(() {
        currentCountryCode = value.code;
      });
    });
  }

  Future<void> changeCountry(String code) async {
    final country =
        widget.countryCodes.firstWhere((element) => element.code == code);
    final entity = CountryCompanion(
      id: const drift.Value(1),
      code: drift.Value(country.code),
      name: drift.Value(country.name),
    );
    if (await Provider.of<AppDb>(context, listen: false).isEmptyTable()) {
      await Provider.of<AppDb>(context, listen: false).insertCountry(entity);
    } else {
      await Provider.of<AppDb>(context, listen: false).updateCountry(entity);
    }
    refreshMoviesList(code);
  }

  void refreshMoviesList(String code) {
    Provider.of<MovieProvider>(context, listen: false)
        .fecthAndSetUpcomingMovies(code);
    Provider.of<MovieProvider>(context, listen: false)
        .fecthAndSetNowPlayingMovies(code);
    setState(() {
      currentCountryCode = code;
    });
  }

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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: appbarTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (_) {
                      return SimpleDialog(
                        title: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Choose a country')),
                        ),
                        children: <Widget>[
                          for (var country in widget.countryCodes)
                            SimpleDialogOption(
                              onPressed: () {
                                changeCountry(country.code);
                                Navigator.of(context).pop();
                              },
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        country.name,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "http://www.geognos.com/api/en/countries/flag/$currentCountryCode.png"),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
