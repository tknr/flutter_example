import 'package:isar/isar.dart';
import 'package:my_app/utils/CurrentInfo.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart' as foundation;
import 'package:path_provider/path_provider.dart';
import 'Counter/CounterRepository.dart';
import 'package:my_app/isar/collections/counter.dart';
import 'dart:async';
import 'dart:io';

class Repositories {

  /// Isarインスタンス
  final Isar isar;

  const Repositories({required this.isar});

  getCounterRepository() {
    log('${CurrentInfo(StackTrace.current).getString()}');
    return CounterRepository(this.isar);
  }
}
