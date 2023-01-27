import 'dart:async';

import 'package:isar/isar.dart';
import 'package:my_app/collections/counter.dart';
import 'dart:developer';

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
    log('CounterRepository findCounters isar.isOpen : ${isar.isOpen} ');
    if (!isar.isOpen) {
      return [];
    }
    final builder = isar.counters.where();

    var ret = sync ? builder.findAllSync() : await builder.findAll();
    log('CounterRepository getCounters ret : $ret ');
    return ret;
  }

  Future<Counter?> getCounter() async {
    log('CounterRepository getCounter isar.isOpen : ${isar.isOpen} ');
    if (!isar.isOpen) {
      return null;
    }
    final counter = await isar.counters.where().findFirst();
    log('CounterRepository getCounter counter : ${counter} ');
    return counter;
  }

  FutureOr<void> addCounter({required int count}) {
    log('CounterRepository addCounter isar.isOpen : ${isar.isOpen} count:${count}');
    if (!isar.isOpen) {
      return Future<void>(() {});
    }
    final now = DateTime.now();
    final counters = Counter()
      ..counter = count
      ..createdAt = now
      ..updatedAt = now;
    log('CounterRepository addCounter counters : ${counters}');
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
    log('CounterRepository updateCounter isar.isOpen : ${isar.isOpen} counters:${counters} count:${count}');
    if (!isar.isOpen) {
      return Future<void>(() {});
    }
    final now = DateTime.now();
    counters
      ..counter = count
      ..createdAt = now
      ..updatedAt = now;
    log('CounterRepository updateCounter counters : ${counters}');

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
