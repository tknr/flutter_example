// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:isar/isar.dart';
import 'package:my_app/main.dart';
import 'package:my_app/app.dart';
import 'package:my_app/repository/Repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_app/collections/counter.dart';
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
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
    await tester.pumpWidget(App(repositories: Repositories(isar: isar),));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
