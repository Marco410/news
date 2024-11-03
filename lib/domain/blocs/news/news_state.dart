import 'package:news/data/models/new_model.dart';

abstract class ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  final bool hasReachedEnd;

  ArticleLoaded(this.articles, {this.hasReachedEnd = false});
}

class ArticleFiltered extends ArticleState {
  final List<Article> articles;

  ArticleFiltered(this.articles);
}

class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);
}
