import 'package:equatable/equatable.dart';
import 'package:news/data/models/new_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleLoading extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  final bool hasReachedEnd;

  ArticleLoaded(this.articles, {this.hasReachedEnd = false});

  @override
  List<Object> get props => [articles, hasReachedEnd];
}

class ArticleFiltered extends ArticleState {
  final List<Article> articles;

  ArticleFiltered(this.articles);
  @override
  List<Object> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);

  @override
  List<Object> get props => [message];
}
