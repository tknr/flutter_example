import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Counters])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future insertCounter(Counter counter) => into(counters).insert(counter);
  Future<List<Counter>> get selectCounters => select(counters).get();
  Future updateCounter(Counter counter) => update(counters).replace(counter);
  Future deleteCounter(Counter counter) => delete(counters).delete(counter);
  Future upsertCounter(Counter counter) => into(counters).insertOnConflictUpdate(counter);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cnts.db'));
    return NativeDatabase(file);
  });
}

class Counters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get count => integer().nullable()();
}
