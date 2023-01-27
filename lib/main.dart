import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:isar/isar.dart';
import 'package:my_app/repository/Repositories.dart';
import 'package:path_provider/path_provider.dart';

import 'package:my_app/app.dart';
import 'package:my_app/collections/counter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(App(
    repositories: Repositories(isar: isar),
  ));
}
