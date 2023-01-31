import 'package:drift/drift.dart';

class Counters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get count => integer().nullable()();
}
