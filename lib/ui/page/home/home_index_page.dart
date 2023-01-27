import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:my_app/repository/Repositories.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({
    super.key,
    required this.title,
    required this.repositories,
  });
  final String title;
  final Repositories repositories;

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage>
    with WidgetsBindingObserver {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    widget.repositories.getCounterRepository().getCounter().then((counter) {
      log('${runtimeType} initState counter : $counter');
      if (counter == null) {
        _counter = 0;
      } else {
        _counter = counter.counter;
      }
      log('${runtimeType} initState _counter : $_counter');
    });

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _incrementCounter() async {
    /// XXX do not execute async inside setState https://api.flutter.dev/flutter/widgets/State/setState.html
    setState(() {
      _counter++;
      log('${runtimeType} _incrementCounter setState _counter: $_counter');
    });

    widget.repositories.getCounterRepository().getCounter().then((counter) {
      log('${runtimeType} _incrementCounter counter : $counter _counter: $_counter');
      if (counter == null) {
        widget.repositories.getCounterRepository().addCounter(count: _counter);
      } else {
        widget.repositories
            .getCounterRepository()
            .updateCounter(counters: counter, count: _counter);
      }
    });
  }
}
