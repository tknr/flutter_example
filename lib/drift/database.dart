import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:my_app/constance/constance.dart';
import 'package:my_app/constance/tables.dart';
import 'package:my_app/drift/table/counters.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, Constance.db_filename));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: Tables.tables)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future insertCounter(Counter counter) => into(counters).insert(counter);
  Future<List<Counter>> get selectCounters => select(counters).get();
  Future updateCounter(Counter counter) => update(counters).replace(counter);
  Future deleteCounter(Counter counter) => delete(counters).delete(counter);
  Future upsertCounter(Counter counter) =>
      into(counters).insertOnConflictUpdate(counter);
}
