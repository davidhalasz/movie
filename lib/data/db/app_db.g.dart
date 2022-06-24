// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CountryData extends DataClass implements Insertable<CountryData> {
  final int id;
  final String code;
  final String name;
  CountryData({required this.id, required this.code, required this.name});
  factory CountryData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CountryData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      code: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  CountryCompanion toCompanion(bool nullToAbsent) {
    return CountryCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
    );
  }

  factory CountryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountryData(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  CountryData copyWith({int? id, String? code, String? name}) => CountryData(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('CountryData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountryData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name);
}

class CountryCompanion extends UpdateCompanion<CountryData> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  const CountryCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
  });
  CountryCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
  })  : code = Value(code),
        name = Value(name);
  static Insertable<CountryData> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
    });
  }

  CountryCompanion copyWith(
      {Value<int>? id, Value<String>? code, Value<String>? name}) {
    return CountryCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountryCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CountryTable extends Country with TableInfo<$CountryTable, CountryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String?> code = GeneratedColumn<String?>(
      'code', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, code, name];
  @override
  String get aliasedName => _alias ?? 'country';
  @override
  String get actualTableName => 'country';
  @override
  VerificationContext validateIntegrity(Insertable<CountryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CountryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CountryData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CountryTable createAlias(String alias) {
    return $CountryTable(attachedDatabase, alias);
  }
}

class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final int id;
  final int movieId;
  final String originalTitle;
  final String? posterPath;
  final String overview;
  final String releaseDate;
  final double popularity;
  final String genreIds;
  final double voteAverage;
  FavoriteData(
      {required this.id,
      required this.movieId,
      required this.originalTitle,
      this.posterPath,
      required this.overview,
      required this.releaseDate,
      required this.popularity,
      required this.genreIds,
      required this.voteAverage});
  factory FavoriteData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoriteData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      movieId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}movie_id'])!,
      originalTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}original_title'])!,
      posterPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}poster_path']),
      overview: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}overview'])!,
      releaseDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date'])!,
      popularity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity'])!,
      genreIds: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}genre_ids'])!,
      voteAverage: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vote_average'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['movie_id'] = Variable<int>(movieId);
    map['original_title'] = Variable<String>(originalTitle);
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String?>(posterPath);
    }
    map['overview'] = Variable<String>(overview);
    map['release_date'] = Variable<String>(releaseDate);
    map['popularity'] = Variable<double>(popularity);
    map['genre_ids'] = Variable<String>(genreIds);
    map['vote_average'] = Variable<double>(voteAverage);
    return map;
  }

  FavoriteCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: Value(id),
      movieId: Value(movieId),
      originalTitle: Value(originalTitle),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      overview: Value(overview),
      releaseDate: Value(releaseDate),
      popularity: Value(popularity),
      genreIds: Value(genreIds),
      voteAverage: Value(voteAverage),
    );
  }

  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteData(
      id: serializer.fromJson<int>(json['id']),
      movieId: serializer.fromJson<int>(json['movieId']),
      originalTitle: serializer.fromJson<String>(json['originalTitle']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      overview: serializer.fromJson<String>(json['overview']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      popularity: serializer.fromJson<double>(json['popularity']),
      genreIds: serializer.fromJson<String>(json['genreIds']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'movieId': serializer.toJson<int>(movieId),
      'originalTitle': serializer.toJson<String>(originalTitle),
      'posterPath': serializer.toJson<String?>(posterPath),
      'overview': serializer.toJson<String>(overview),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'popularity': serializer.toJson<double>(popularity),
      'genreIds': serializer.toJson<String>(genreIds),
      'voteAverage': serializer.toJson<double>(voteAverage),
    };
  }

  FavoriteData copyWith(
          {int? id,
          int? movieId,
          String? originalTitle,
          String? posterPath,
          String? overview,
          String? releaseDate,
          double? popularity,
          String? genreIds,
          double? voteAverage}) =>
      FavoriteData(
        id: id ?? this.id,
        movieId: movieId ?? this.movieId,
        originalTitle: originalTitle ?? this.originalTitle,
        posterPath: posterPath ?? this.posterPath,
        overview: overview ?? this.overview,
        releaseDate: releaseDate ?? this.releaseDate,
        popularity: popularity ?? this.popularity,
        genreIds: genreIds ?? this.genreIds,
        voteAverage: voteAverage ?? this.voteAverage,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('movieId: $movieId, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('posterPath: $posterPath, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('popularity: $popularity, ')
          ..write('genreIds: $genreIds, ')
          ..write('voteAverage: $voteAverage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, movieId, originalTitle, posterPath,
      overview, releaseDate, popularity, genreIds, voteAverage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.movieId == this.movieId &&
          other.originalTitle == this.originalTitle &&
          other.posterPath == this.posterPath &&
          other.overview == this.overview &&
          other.releaseDate == this.releaseDate &&
          other.popularity == this.popularity &&
          other.genreIds == this.genreIds &&
          other.voteAverage == this.voteAverage);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<int> id;
  final Value<int> movieId;
  final Value<String> originalTitle;
  final Value<String?> posterPath;
  final Value<String> overview;
  final Value<String> releaseDate;
  final Value<double> popularity;
  final Value<String> genreIds;
  final Value<double> voteAverage;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.movieId = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.overview = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.popularity = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.voteAverage = const Value.absent(),
  });
  FavoriteCompanion.insert({
    this.id = const Value.absent(),
    required int movieId,
    required String originalTitle,
    this.posterPath = const Value.absent(),
    required String overview,
    required String releaseDate,
    required double popularity,
    required String genreIds,
    required double voteAverage,
  })  : movieId = Value(movieId),
        originalTitle = Value(originalTitle),
        overview = Value(overview),
        releaseDate = Value(releaseDate),
        popularity = Value(popularity),
        genreIds = Value(genreIds),
        voteAverage = Value(voteAverage);
  static Insertable<FavoriteData> custom({
    Expression<int>? id,
    Expression<int>? movieId,
    Expression<String>? originalTitle,
    Expression<String?>? posterPath,
    Expression<String>? overview,
    Expression<String>? releaseDate,
    Expression<double>? popularity,
    Expression<String>? genreIds,
    Expression<double>? voteAverage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (movieId != null) 'movie_id': movieId,
      if (originalTitle != null) 'original_title': originalTitle,
      if (posterPath != null) 'poster_path': posterPath,
      if (overview != null) 'overview': overview,
      if (releaseDate != null) 'release_date': releaseDate,
      if (popularity != null) 'popularity': popularity,
      if (genreIds != null) 'genre_ids': genreIds,
      if (voteAverage != null) 'vote_average': voteAverage,
    });
  }

  FavoriteCompanion copyWith(
      {Value<int>? id,
      Value<int>? movieId,
      Value<String>? originalTitle,
      Value<String?>? posterPath,
      Value<String>? overview,
      Value<String>? releaseDate,
      Value<double>? popularity,
      Value<String>? genreIds,
      Value<double>? voteAverage}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      movieId: movieId ?? this.movieId,
      originalTitle: originalTitle ?? this.originalTitle,
      posterPath: posterPath ?? this.posterPath,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      popularity: popularity ?? this.popularity,
      genreIds: genreIds ?? this.genreIds,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String?>(posterPath.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCompanion(')
          ..write('id: $id, ')
          ..write('movieId: $movieId, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('posterPath: $posterPath, ')
          ..write('overview: $overview, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('popularity: $popularity, ')
          ..write('genreIds: $genreIds, ')
          ..write('voteAverage: $voteAverage')
          ..write(')'))
        .toString();
  }
}

class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _movieIdMeta = const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int?> movieId = GeneratedColumn<int?>(
      'movie_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _originalTitleMeta =
      const VerificationMeta('originalTitle');
  @override
  late final GeneratedColumn<String?> originalTitle = GeneratedColumn<String?>(
      'original_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _posterPathMeta = const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String?> posterPath = GeneratedColumn<String?>(
      'poster_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String?> overview = GeneratedColumn<String?>(
      'overview', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String?> releaseDate = GeneratedColumn<String?>(
      'release_date', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _popularityMeta = const VerificationMeta('popularity');
  @override
  late final GeneratedColumn<double?> popularity = GeneratedColumn<double?>(
      'popularity', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _genreIdsMeta = const VerificationMeta('genreIds');
  @override
  late final GeneratedColumn<String?> genreIds = GeneratedColumn<String?>(
      'genre_ids', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double?> voteAverage = GeneratedColumn<double?>(
      'vote_average', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        movieId,
        originalTitle,
        posterPath,
        overview,
        releaseDate,
        popularity,
        genreIds,
        voteAverage
      ];
  @override
  String get aliasedName => _alias ?? 'favorite';
  @override
  String get actualTableName => 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    if (data.containsKey('original_title')) {
      context.handle(
          _originalTitleMeta,
          originalTitle.isAcceptableOrUnknown(
              data['original_title']!, _originalTitleMeta));
    } else if (isInserting) {
      context.missing(_originalTitleMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity']!, _popularityMeta));
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('genre_ids')) {
      context.handle(_genreIdsMeta,
          genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta));
    } else if (isInserting) {
      context.missing(_genreIdsMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoriteData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CountryTable country = $CountryTable(this);
  late final $FavoriteTable favorite = $FavoriteTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [country, favorite];
}
