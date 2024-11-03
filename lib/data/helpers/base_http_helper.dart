import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:news/data/config/const/const.dart';

Future<String> httpBase(
    {required String type,
    required String path,
    Map<String, String>? headers,
    Map<String, String>? params,
    required String typeResponse}) async {
  http.Response response = http.Response("", 500);
  try {
    Uri url = Uri.https(baseUrl, path, params);

    headers ??= {};
    headers["Content-type"] = "application/json";
    headers["Accept"] = "*/*";

    late String body;
    switch (type) {
      case "GET":
        response = await http.get(url, headers: headers);
        body = response.body;
        break;
    }

    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception("Failed to load $typeResponse");
    }
  } catch (e) {
    throw Exception("Failed to load $typeResponse");
  }
}
