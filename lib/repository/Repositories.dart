import 'package:isar/isar.dart';
import 'package:my_app/utils/CurrentInfo.dart';
import 'dart:developer';
import 'Counter/CounterRepository.dart';

class Repositories {
  /// Isarインスタンス
  final Isar isar;

  const Repositories({required this.isar});

  getCounterRepository() {
    log('${CurrentInfo(StackTrace.current).getString()}');
    return CounterRepository(isar);
  }
}
