abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {
  final String? category;

  FetchArticles(this.category);
}

class FetchMoreArticles extends ArticleEvent {}
