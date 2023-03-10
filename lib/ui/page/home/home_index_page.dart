import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/drift/database.dart';
import 'package:my_app/ui/appbar/common_appbar.dart';
import 'package:my_app/ui/drawer/common_drawer.dart';
import 'package:my_app/ui/page/RouteNames.dart';
import 'package:my_app/utils/CurrentInfo.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({
    super.key,
    required this.title,
    required this.db,
  });
  final String title;
  final MyDatabase db;

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage>
    with WidgetsBindingObserver {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _initCounter();

    WidgetsBinding.instance.addObserver(this);
  }

  void _initCounter() async {
    List<Counter> counters = await widget.db.selectCounters;
    log('${CurrentInfo(StackTrace.current).getString()} counters: $counters');
    if (counters.isEmpty) {
      return;
    }
    Counter counter = counters.singleWhere((element) => element.id == 1);
    log('${CurrentInfo(StackTrace.current).getString()} counter: $counter');
    setState(() {
      _counter = counter.count!;
      log('${CurrentInfo(StackTrace.current).getString()} _counter: $_counter');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('${CurrentInfo(StackTrace.current).getString()} state = $state');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: CommonAppBar.get(widget.title),
      drawer:CommonDrawer.get(context),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
       */
      persistentFooterButtons: <Widget>[
        ElevatedButton.icon(
          onPressed: _incrementCounter,
          icon: Icon(LineIcons.plus),
          label: Text('increment'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              splashFactory: InkSplash.splashFactory),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.next);
          },
          icon: FaIcon(FontAwesomeIcons.forwardFast),
          label: const Text('next'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              splashFactory: InkSplash.splashFactory),
        ),
      ],
    );
  }

  void _incrementCounter() async {
    /// XXX do not execute async inside setState https://api.flutter.dev/flutter/widgets/State/setState.html
    setState(() {
      _counter++;
      log('${CurrentInfo(StackTrace.current).getString()} _counter: $_counter');
    });

    _upsertCounters();
  }

  void _upsertCounters() async {
    var counter = Counter(id: 1, count: _counter);
    List<Counter> counters = await widget.db.selectCounters;
    if (counters.isEmpty) {
      await widget.db.insertCounter(counter);
      log('${CurrentInfo(StackTrace.current).getString()} insertCounter counter: $counter');
    } else {
      await widget.db.updateCounter(counter);
      log('${CurrentInfo(StackTrace.current).getString()} updateCounter counter: $counter');
    }
  }
}
