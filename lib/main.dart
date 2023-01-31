import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/app.dart';
import 'package:my_app/drift/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = MyDatabase();

  runApp(App(db: database));
}
