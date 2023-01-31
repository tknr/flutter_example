import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_app/utils/CurrentInfo.dart';

class GoogleBooksTestApi {
  static Future<List<dynamic>> getData(
      {String q = 'Flutter',
      int startIndex = 0,
      int maxResults = 40,
      String langRestrict = 'ja'}) async {
    CurrentInfo(StackTrace.current).log(
        'q: $q startIndex : $startIndex maxResults: $maxResults langRestrict: $langRestrict');

    /// @see https://developers.google.com/books/docs/v1/using?hl=ja
    var response =
        await http.get(Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{${q}}',
      'startIndex': startIndex.toString(),
      'maxResults': maxResults.toString(),
      'langRestrict': langRestrict
    }));

    CurrentInfo(StackTrace.current).log('response: $response');

    var jsonResponse = jsonDecode(response.body);

    var items = jsonResponse['items'];
    CurrentInfo(StackTrace.current).log('items: $items');
    return items;
  }
}
