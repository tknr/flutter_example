import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/api/google/books/GoogleBooksTestApi.dart';
import 'package:my_app/constance/RouteNames.dart';
import 'package:my_app/drift/database.dart';
import 'package:my_app/ui/common/appbar/common_appbar.dart';
import 'package:my_app/ui/common/drawer/common_drawer.dart';
import 'package:my_app/utils/CurrentInfo.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List _items = [];
  String _searchQuery = '{Flutter}';

  @override
  void initState() {
    super.initState();

    _initApiData();

    WidgetsBinding.instance.addObserver(this);
  }

  void _initApiData() async {
    log('${CurrentInfo(StackTrace.current).getString()}');
    GoogleBooksTestApi.getData(q: _searchQuery).then((value) {
      setState(() {
        _items = value;
        _switchSearchQuery();
      });
    });
  }

  void _refreshApiData() async {
    log('${CurrentInfo(StackTrace.current).getString()}');
    GoogleBooksTestApi.getData(q: _searchQuery).then((value) {
      setState(() {
        _items = value;
        _switchSearchQuery();
      });
    });
  }

  void _switchSearchQuery() {
    if (_searchQuery == '{laravel}') {
      _searchQuery = '{Flutter}';
    } else {
      _searchQuery = '{laravel}';
    }
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
    return Scaffold(
      appBar: CommonAppBar.get(widget.title),
      drawer: CommonDrawer.get(context),
      body: RefreshIndicator(
          onRefresh: () async {
            _refreshApiData();
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image(
                        image: CachedNetworkImageProvider(_items[index]
                            ['volumeInfo']['imageLinks']['thumbnail']),
                      ),
                      title: Text(_items[index]['volumeInfo']['title']),
                      subtitle:
                          Text(_items[index]['volumeInfo']['publishedDate']),
                      onTap: () {
                        log('${CurrentInfo(StackTrace.current).getString()} _item: ${_items[index]['volumeInfo']}');
                        _openUrl(
                            _items[index]['volumeInfo']['canonicalVolumeLink']);
                      },
                    ),
                  ],
                ),
              );
            },
          )),
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
            Navigator.pushNamed(context, RouteNames.home_index);
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

  void _openUrl(url) async {
    log('${CurrentInfo(StackTrace.current).getString()} url: $url');
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}
