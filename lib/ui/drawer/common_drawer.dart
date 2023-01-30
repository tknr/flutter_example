import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_app/ui/page/RouteNames.dart';
import 'package:my_app/utils/CurrentInfo.dart';

class CommonDrawer {
  static get(BuildContext context) {
    log('${CurrentInfo(StackTrace.current).getString()} context : ${context}');
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteNames.home);
            },
          ),
          ListTile(
              title: Text('next'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.next);
              }),
        ],
      ),
    );
  }
}
