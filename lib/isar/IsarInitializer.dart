import 'package:isar/isar.dart';
import 'package:my_app/utils/CurrentInfo.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart' as foundation;
import 'package:path_provider/path_provider.dart';
import 'package:my_app/isar/collections/counter.dart';
import 'dart:async';
import 'dart:io';
class IsarInitializer{

  init() async{
    // リポジトリの初期化
    // path_provider は Web に非対応
    var path = '';
    if (!foundation.kIsWeb) {
      final dir = await getApplicationSupportDirectory();
      path = dir.path;
    }

    final isar = await Isar.open(
      [
        CounterSchema,
      ],
      directory: path,
    );

    return isar;
  }
}