import 'package:flutter/material.dart';
import 'package:movies/data/db/app_db.dart';
import 'package:movies/screens/mainPage/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (context) => AppDb(),
      child: const MyApp(),
      dispose: (context, AppDb db) => db.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
