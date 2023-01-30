import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/utils/CurrentInfo.dart';

class CommonAppBar {
  static get(String title) {
    log('${CurrentInfo(StackTrace.current).getString()} title: $title');
    return AppBar(
      title: Text(title),
    );
  }
}
