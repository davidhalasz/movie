import 'package:drift/drift.dart';

class Favorite extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get movieId => integer()();
  TextColumn get originalTitle => text()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get overview => text()();
  TextColumn get releaseDate => text()();
  RealColumn get popularity => real()();
  TextColumn get genreIds => text()();
  RealColumn get voteAverage => real()();
}
