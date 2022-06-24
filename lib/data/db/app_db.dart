import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../country_database.dart';
import '../favorite_database.dart';
part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase((() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'movies.sqlite'));

    return NativeDatabase(file);
  }));
}

@DriftDatabase(tables: [Country, Favorite])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        beforeOpen: (details) async {
          if (details.wasCreated) {
            // create default categories and entries
            await into(country).insert(
              const CountryCompanion(
                code: Value('HU'),
                name: Value("Hungary"),
              ),
            );
          }
        },
      );

  Future<CountryData> getCountry() {
    var singleCountry = select(country)..where((t) => t.id.equals(1));
    return singleCountry.getSingle();
  }

  Future<bool> isEmptyTable() async {
    var result = await select(country).get();
    return result.isEmpty;
  }

  Future<bool> updateCountry(CountryCompanion entity) async {
    return await update(country).replace(entity);
  }

  Future<int> insertCountry(CountryCompanion entity) async {
    return await into(country).insert(entity);
  }

  Future<List<FavoriteData>> getFavorites() async {
    return await select(favorite).get();
  }

  Future<int> insertFavorite(FavoriteCompanion entity) async {
    return await into(favorite).insert(entity);
  }

  deleteFavoriteMovie(FavoriteData entity) {
    return delete(favorite).delete(entity);
  }

  deleteAllFavoriteMovies() async {
    var movies = await getFavorites();
    for (var m in movies) {
      deleteFavoriteMovie(m);
    }
  }

  Future<int> deleteFavoriteByMovieId(int movieId) async {
    var movie = await getFavoriteMovieById(movieId);
    return await deleteFavoriteMovie(movie!);
  }

  Future<FavoriteData?> getFavoriteMovieById(int movieId) async {
    var selectedMovie = select(favorite)
      ..where((t) => t.movieId.equals(movieId));
    return selectedMovie.getSingleOrNull();
  }

  Future<bool> isExistsFavoriteMovie(int movieId) async {
    var movies = await getFavorites();
    for (var movie in movies) {
      if (movie.movieId == movieId) {
        return true;
      }
    }
    return false;
  }
}
