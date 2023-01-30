import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/drift/database.dart';
import 'package:my_app/ui/appbar/common_appbar.dart';
import 'package:my_app/ui/drawer/common_drawer.dart';
import 'package:my_app/ui/page/RouteNames.dart';
import 'package:my_app/utils/CurrentInfo.dart';

class NextIndexPage extends StatefulWidget {
  const NextIndexPage({
    super.key,
    required this.title,
    required this.db,
  });
  final String title;
  final MyDatabase db;

  @override
  State<NextIndexPage> createState() => _NextIndexPageState();
}

class _NextIndexPageState extends State<NextIndexPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.get(widget.title),
      drawer:CommonDrawer.get(context),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('next page'),
            ]),
      ),
      persistentFooterButtons: <Widget>[
        ElevatedButton.icon(
          onPressed: _resetCounter,
          icon: Icon(LineIcons.trash),
          label: const Text('reset'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              splashFactory: InkSplash.splashFactory),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.home);
          },
          icon: FaIcon(FontAwesomeIcons.backwardFast),
          label: const Text('back'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              splashFactory: InkSplash.splashFactory),
        ),
      ],
    );
  }

  void _resetCounter() async {
    setState(() {});

    _deleteCounters();
  }

  void _deleteCounters() async {
    List<Counter> counters = await widget.db.selectCounters;
    if (counters.isEmpty) {
      log('${CurrentInfo(StackTrace.current).getString()} no counters: $counters');
      return;
    }
    Counter counter = counters.singleWhere((element) => element.id == 1);
    log('${CurrentInfo(StackTrace.current).getString()} deleting counter: $counter');
    await widget.db.deleteCounter(counter);
  }
}
