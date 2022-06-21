import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../country_database.dart';
part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase((() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'country.sqlite'));

    return NativeDatabase(file);
  }));
}

@DriftDatabase(tables: [Country])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
}
