import 'package:flutter/material.dart';
import 'package:my_app/repository/Repositories.dart';
import 'package:my_app/ui/page/home/home_index_page.dart';
import 'dart:developer';
import 'package:my_app/repository/Counter/CounterRepository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.repositories,
  });

  final Repositories repositories;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.brown,
      ),
      home: HomeIndexPage(
          title: 'Flutter Demo Home Page', repositories: this.repositories),
    );
  }
}
