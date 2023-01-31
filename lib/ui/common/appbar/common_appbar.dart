import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/utils/CurrentInfo.dart';

class CommonAppBar {
  static get(String title) {
    CurrentInfo(StackTrace.current).log('title: $title');
    return AppBar(
      title: Text(title),
    );
  }
}
