import 'package:isar/isar.dart';
import 'dart:developer';
import 'Counter/CounterRepository.dart';

class Repositories {
  /// Isarインスタンス
  final Isar isar;

  const Repositories({required this.isar});

  getCounterRepository() {
    log('Repositories getCounterRepository');
    return CounterRepository(isar);
  }
}
