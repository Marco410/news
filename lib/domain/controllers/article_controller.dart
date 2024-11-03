import 'package:news/data/config/const/const.dart';
import 'dart:convert';
import 'package:news/data/models/new_model.dart';
import 'package:news/domain/service/http_general_service.dart';

class ArticleController {
  Future<List<Article>> fetchArticles(
      {int page = 1, int limit = 10, String? category}) async {
    final paramsData = {"language": "es", "q": "google", "apiKey": apiKey};
    String urlGet = articlesGet;

    if (category != null) {
      paramsData['category'] = category;
      paramsData['language'] =
          "en"; //For test purposes, so we can get articles from a category, if not, it will return 0 articles
      urlGet = articlesWithCategoryGet;
    }

    String res = await BaseHttpService.baseGet(url: urlGet, params: paramsData);
    NewModel newsResponse = NewModel.fromJson(json.decode(res));
    return newsResponse.articles;
  }
}
