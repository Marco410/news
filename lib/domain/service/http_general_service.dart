import 'dart:async';

import '../../data/helpers/base_http_helper.dart';

class BaseHttpService {
  static Future<String> baseGet(
      {required String url, Map<String, String>? params}) async {
    String? response = await httpBase(
        type: "GET", path: url, params: params, typeResponse: 'articles');
    return response;
  }
}
