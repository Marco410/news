import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/blocs/news/news_event.dart';
import 'package:news/domain/blocs/news/news_state.dart';
import 'package:news/domain/controllers/article_controller.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleController articleController;
  final int articlesPerPage = 10;
  int currentPage = 1;

  ArticleBloc(this.articleController) : super(ArticleLoading()) {
    on<FetchArticles>(_onFetchArticles);
    on<FetchMoreArticles>(_onFetchMoreArticles);
  }

  Future<void> _onFetchArticles(
      FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    currentPage = 1;

    try {
      final articles = await articleController.fetchArticles(
          page: currentPage, limit: articlesPerPage, category: event.category);
      emit(ArticleLoaded(articles,
          hasReachedEnd: articles.length < articlesPerPage));
    } catch (e) {
      emit(ArticleError("Error: $e"));
    }
  }

  Future<void> _onFetchMoreArticles(
      FetchMoreArticles event, Emitter<ArticleState> emit) async {
    if (state is ArticleLoaded && !(state as ArticleLoaded).hasReachedEnd) {
      currentPage += 1;
      try {
        final moreArticles = await articleController.fetchArticles(
            page: currentPage, limit: articlesPerPage);
        if (moreArticles.isEmpty) {
          emit(ArticleLoaded((state as ArticleLoaded).articles,
              hasReachedEnd: true));
        } else {
          emit(ArticleLoaded(
            (state as ArticleLoaded).articles + moreArticles,
            hasReachedEnd: moreArticles.length < articlesPerPage,
          ));
        }
      } catch (e) {
        emit(ArticleError("Error: $e"));
      }
    }
  }
}
