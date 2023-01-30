import 'dart:async';

import 'package:isar/isar.dart';
import 'package:my_app/isar/collections/counter.dart';
import 'dart:developer';

import 'package:my_app/utils/CurrentInfo.dart';

class CounterRepository {
  CounterRepository(
    this.isar, {
    this.sync = false,
  });

  /// Isarインスタンス
  final Isar isar;

  /// 非同期かどうか
  final bool sync;

  /// get all Counter
  FutureOr<List<Counter>> findCounters() async {
    log('${CurrentInfo(StackTrace.current).getString()} isar.isOpen : ${isar.isOpen}');
    if (!isar.isOpen) {
      return [];
    }
    final builder = isar.counters.where();

    var ret = sync ? builder.findAllSync() : await builder.findAll();
    log('${StackTrace.current.toString().split('\n')[0]} ret : $ret');
    return ret;
  }

  Future<Counter?> getCounter() async {
    log('${CurrentInfo(StackTrace.current).getString()} isar.isOpen : ${isar.isOpen}');
    if (!isar.isOpen) {
      return null;
    }
    final counter = await isar.counters.where().findFirst();
    log('${CurrentInfo(StackTrace.current).getString()} getCounter counter : ${counter}');
    return counter;
  }

  FutureOr<void> addCounter({required int count}) {
    log('${CurrentInfo(StackTrace.current).getString()} isar.isOpen : ${isar.isOpen} count:${count}',
        name: this.runtimeType.toString());
    if (!isar.isOpen) {
      return Future<void>(() {});
    }
    final now = DateTime.now();
    final counters = Counter()
      ..counter = count
      ..createdAt = now
      ..updatedAt = now;
    log('${CurrentInfo(StackTrace.current).getString()} counters : ${counters}');
    if (sync) {
      isar.writeTxnSync<void>(() {
        isar.counters.putSync(counters);
      });
    } else {
      return isar.writeTxn(() async {
        await isar.counters.put(counters);
      });
    }
  }

  FutureOr<void> updateCounter(
      {required Counter counters, required int count}) {
    log('${CurrentInfo(StackTrace.current).getString()} isar.isOpen : ${isar.isOpen} counters:${counters} count:${count}');
    if (!isar.isOpen) {
      return Future<void>(() {});
    }
    final now = DateTime.now();
    counters
      ..counter = count
      ..createdAt = now
      ..updatedAt = now;
    log('${CurrentInfo(StackTrace.current).getString()} counters : ${counters}');

    if (sync) {
      isar.writeTxnSync<void>(() {
        isar.counters.putSync(counters);
      });
    } else {
      return isar.writeTxn(() async {
        await isar.counters.put(counters);
      });
    }
  }
}
