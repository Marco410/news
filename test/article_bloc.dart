import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news/data/models/new_model.dart';
import 'package:news/domain/blocs/news/news_bloc.dart';
import 'package:news/domain/blocs/news/news_event.dart';
import 'package:news/domain/blocs/news/news_state.dart';
import 'package:news/domain/controllers/article_controller.dart';

// Crear una clase Mock para el ArticleController
class MockArticleController extends Mock implements ArticleController {}

void main() {
  group('ArticleBloc', () {
    late ArticleBloc articleBloc;
    late MockArticleController mockRepository;

    setUp(() {
      mockRepository = MockArticleController();
      articleBloc = ArticleBloc(mockRepository);
    });

    tearDown(() {
      articleBloc.close();
    });

    test('initial state is ArticleLoading', () {
      expect(articleBloc.state, equals(ArticleLoading()));
    });

    blocTest<ArticleBloc, ArticleState>(
      'emits [ArticleLoading, ArticleLoaded] when FetchArticles is added',
      build: () {
        when(mockRepository.fetchArticles(page: 1, limit: 10)).thenAnswer(
          (_) async => [
            Article(
              author: "author",
              content: "content",
              description: "description",
              publishedAt: DateTime(2024, 1, 1),
              source: Source(id: "id", name: "name"),
              title: "title",
              url: "url",
              urlToImage: "urlToImage",
            ),
          ],
        );
        return articleBloc;
      },
      act: (bloc) => bloc.add(FetchArticles(null)),
      expect: () => [
        ArticleLoading(),
        ArticleLoaded([
          Article(
            author: "author",
            content: "content",
            description: "description",
            publishedAt: DateTime(2024, 1, 1),
            source: Source(id: "id", name: "name"),
            title: "title",
            url: "url",
            urlToImage: "urlToImage",
          ),
        ]),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'emits [ArticleLoading, ArticleFiltered] when FilterArticlesByCategory is added',
      build: () {
        when(mockRepository.fetchArticles(
                page: 1, limit: 10, category: "sports"))
            .thenAnswer(
          (_) async => [
            Article(
              author: "author",
              content: "content",
              description: "description",
              publishedAt: DateTime(2024, 1, 1),
              source: Source(id: "id", name: "name"),
              title: "title",
              url: "url",
              urlToImage: "urlToImage",
            ),
          ],
        );
        return articleBloc;
      },
      act: (bloc) => bloc.add(FetchArticles("sports")),
      expect: () => [
        ArticleLoading(),
        ArticleFiltered([
          Article(
            author: "author",
            content: "content",
            description: "description",
            publishedAt: DateTime(2024, 1, 1),
            source: Source(id: "id", name: "name"),
            title: "title",
            url: "url",
            urlToImage: "urlToImage",
          ),
        ]),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'emits [ArticleError] when FetchArticles fails',
      build: () {
        // Configura la respuesta antes de devolver el bloc
        when(mockRepository.fetchArticles(page: 1, limit: 10))
            .thenThrow(Exception("Error"));
        return articleBloc;
      },
      act: (bloc) => bloc.add(FetchArticles(null)),
      expect: () => [
        ArticleLoading(),
        ArticleError("Error: Exception: Error"),
      ],
    );
  });
}
