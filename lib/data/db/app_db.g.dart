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

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CountryTable country = $CountryTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [country];
}
