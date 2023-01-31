import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _searchQuery = 'Flutter';

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
        //_switchSearchQuery();
      });
    });
  }

  void _refreshApiData() async {
    log('${CurrentInfo(StackTrace.current).getString()}');
    GoogleBooksTestApi.getData(q: _searchQuery).then((value) {
      setState(() {
        _items = value;
        //_switchSearchQuery();
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CurrentInfo(StackTrace.current).log('state = $state');
  }

  final _controller = TextEditingController();
  void _handleText(String e) {
    if (e.length > 0) {
      setState(() {
        _searchQuery = e;
        CurrentInfo(StackTrace.current).log('_searchQuery = $_searchQuery');
      });
      _refreshApiData();
    }
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
            var _item = _items[index];
            var _volumeInfo = _item['volumeInfo'];
            /*
            CurrentInfo(StackTrace.current)
                .log('index : $index _volumeInfo: ${_volumeInfo}');
             */
            var _leadingImage = Image.asset('assets/images/noimage.png');
            if (_volumeInfo['imageLinks'] != null &&
                _volumeInfo['imageLinks']['thumbnail'] != null) {
              _leadingImage = Image(
                  image: CachedNetworkImageProvider(
                      _volumeInfo['imageLinks']['thumbnail']));
            }
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: _leadingImage,
                    title: Text(_volumeInfo['title'] ??= '-'),
                    subtitle: Text(_volumeInfo['publishedDate'] ??= '-'),
                    onTap: () {
                      if (_volumeInfo['canonicalVolumeLink'] != null) {
                        _openUrl(_volumeInfo['canonicalVolumeLink']);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: <Widget>[
        SizedBox(
            width: 180,
            child: TextFormField(
              enabled: true,
              maxLines: 1,
              maxLength: 20,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              obscureText: false,
              onChanged: _handleText,
              initialValue: _searchQuery,
            )),
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
      CurrentInfo(StackTrace.current).log('no counters: $counters');
      return;
    }
    Counter counter = counters.singleWhere((element) => element.id == 1);
    CurrentInfo(StackTrace.current).log('deleting counter: $counter');
    await widget.db.deleteCounter(counter);
  }

  void _openUrl(url) async {
    CurrentInfo(StackTrace.current).log('url: $url');
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}
