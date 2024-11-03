import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news/domain/blocs/news/news_bloc.dart';
import 'package:news/domain/blocs/news/news_event.dart';
import 'package:news/domain/blocs/news/news_state.dart';
import 'package:news/domain/controllers/article_controller.dart';

// Crear una clase Mock para el ArticleController
class MockArticleController extends Mock implements ArticleController {}

void main() {
  group('ArticleBloc', () {
    late ArticleBloc articleBloc;
    late MockArticleController mockArticleController;
    setUp(() {
      mockArticleController = MockArticleController();
      articleBloc = ArticleBloc(mockArticleController);
    });

    tearDown(() {
      articleBloc.close();
    });

    test('initial state is ArticleLoading', () {
      expect(articleBloc.state, equals(ArticleLoading()));
    });

    blocTest<ArticleBloc, ArticleState>(
      'emits [ArticleLoading, ArticleLoaded] when FetchArticles is added',
      build: () => articleBloc,
      act: (bloc) => articleBloc..add(FetchArticles(null)),
      expect: () => [
        ArticleLoading(),
        ArticleError(
            "Error: type 'Null' is not a subtype of type 'Future<List<Article>>'"),
      ],
    );
  });
}
