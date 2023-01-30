// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Counter extends DataClass implements Insertable<Counter> {
  final int id;
  final int? count;
  Counter({required this.id, this.count});
  factory Counter.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Counter(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      count: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int?>(count);
    }
    return map;
  }

  CountersCompanion toCompanion(bool nullToAbsent) {
    return CountersCompanion(
      id: Value(id),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
    );
  }

  factory Counter.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Counter(
      id: serializer.fromJson<int>(json['id']),
      count: serializer.fromJson<int?>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'count': serializer.toJson<int?>(count),
    };
  }

  Counter copyWith({int? id, int? count}) => Counter(
        id: id ?? this.id,
        count: count ?? this.count,
      );
  @override
  String toString() {
    return (StringBuffer('Counter(')
          ..write('id: $id, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, count);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Counter && other.id == this.id && other.count == this.count);
}

class CountersCompanion extends UpdateCompanion<Counter> {
  final Value<int> id;
  final Value<int?> count;
  const CountersCompanion({
    this.id = const Value.absent(),
    this.count = const Value.absent(),
  });
  CountersCompanion.insert({
    this.id = const Value.absent(),
    this.count = const Value.absent(),
  });
  static Insertable<Counter> custom({
    Expression<int>? id,
    Expression<int?>? count,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (count != null) 'count': count,
    });
  }

  CountersCompanion copyWith({Value<int>? id, Value<int?>? count}) {
    return CountersCompanion(
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (count.present) {
      map['count'] = Variable<int?>(count.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountersCompanion(')
          ..write('id: $id, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }
}

class $CountersTable extends Counters with TableInfo<$CountersTable, Counter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int?> count = GeneratedColumn<int?>(
      'count', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, count];
  @override
  String get aliasedName => _alias ?? 'counters';
  @override
  String get actualTableName => 'counters';
  @override
  VerificationContext validateIntegrity(Insertable<Counter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Counter map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Counter.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CountersTable createAlias(String alias) {
    return $CountersTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CountersTable counters = $CountersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [counters];
}
