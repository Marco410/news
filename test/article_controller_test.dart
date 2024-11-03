import 'package:flutter_test/flutter_test.dart';
import 'package:news/data/models/new_model.dart';
import 'package:news/domain/controllers/article_controller.dart';

void main() {
  group('ArticleController', () {
    late ArticleController articleController;

    setUp(() {
      articleController = ArticleController();
    });

    test('fetchArticles returns list of articles', () async {
      final articles =
          await articleController.fetchArticles(page: 1, limit: 10);

      expect(articles, isA<List<Article>>());
      expect(articles.length, 100);
      expect(articles[0].title,
          "Android 15 ya está disponible en los Pixel de Google");
    });
  });
}
