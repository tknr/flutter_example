import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_app/utils/CurrentInfo.dart';

class GoogleBooksTestApi {
  static Future<List<dynamic>> getData(
      {String q = '{Flutter}',
      String maxResults = '40',
      String langRestrict = 'ja'}) async {
    log('${CurrentInfo(StackTrace.current).getString()} q: $q maxResults: $maxResults langRestrict: $langRestrict');

    var response = await http.get(Uri.https(
        'www.googleapis.com',
        '/books/v1/volumes',
        {'q': q, 'maxResults': maxResults, 'langRestrict': langRestrict}));

    log('${CurrentInfo(StackTrace.current).getString()} response: $response');

    var jsonResponse = jsonDecode(response.body);

    var items = jsonResponse['items'];
    log('${CurrentInfo(StackTrace.current).getString()} items: $items');
    return items;
  }
}
