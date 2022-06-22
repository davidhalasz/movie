import 'package:flutter/material.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/mainPage/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => MovieProvider())),
        Provider<AppDb>(
          create: (context) => AppDb(),
          child: const MyApp(),
          dispose: (context, db) => db.close(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
