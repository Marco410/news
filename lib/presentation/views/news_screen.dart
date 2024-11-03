import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:news/data/models/category_model.dart';
import 'package:news/domain/blocs/news/news_event.dart';
import 'package:news/domain/controllers/article_controller.dart';
import 'package:news/presentation/widgets/article.dart';
import 'package:news/presentation/widgets/error_load.dart';
import 'package:sizer_pro/sizer.dart';

import '../../domain/blocs/news/news_bloc.dart';
import '../../domain/blocs/news/news_state.dart';
import '../widgets/category_widget.dart';
import '../widgets/refresh_btn.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final _scrollController = ScrollController();
  CategoryModel? _selectedCategory;
  double scrollPosition = 0;

  final List<CategoryModel> categories = [
    CategoryModel(name: "Negocios", code: "business"),
    CategoryModel(name: "Entretenimiento", code: "entertainment"),
    CategoryModel(name: "General", code: "general"),
    CategoryModel(name: "Salud", code: "health"),
    CategoryModel(name: "Ciencia", code: "science"),
    CategoryModel(name: "Deportes", code: "sports"),
    CategoryModel(name: "Tecnología", code: "technology"),
  ];

  void scrollTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 600), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Noticias',
            style: TxtStyle.headerStyle,
          )),
      floatingActionButton: (scrollPosition > 200)
          ? FadedScaleAnimation(
              child: InkWell(
                onTap: () => scrollTop(),
                child: Container(
                  height: 20.sp,
                  width: 20.sp,
                  decoration: BoxDecoration(
                      color: ColorStyle.primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: BlocProvider(
        create: (context) =>
            ArticleBloc(ArticleController())..add(FetchArticles(null)),
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 40,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryWidget(
                        category: categories[index],
                        selected: categories[index] == _selectedCategory,
                        onTap: () {
                          if (_selectedCategory == categories[index]) {
                            setState(() {
                              _selectedCategory = null;
                            });
                          } else {
                            setState(() {
                              _selectedCategory = categories[index];
                            });
                          }
                          context
                              .read<ArticleBloc>()
                              .add(FetchArticles(_selectedCategory?.code));
                        },
                      );
                    })),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 15,
              child: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ArticleLoaded ||
                      state is ArticleFiltered) {
                    final articles = (state as dynamic).articles;

                    if (articles.length == 0) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_open_sharp,
                            color: ColorStyle.primaryColor,
                            size: 17.f,
                          ),
                          Text(
                            "No hay articulos para mostrar",
                            style: TxtStyle.labelStyle,
                          ),
                          const SizedBox(height: 5),
                          RefreshButtonWidget(
                            onTap: () {
                              setState(() {
                                _selectedCategory = null;
                              });
                              _refresh(context);
                            },
                          ),
                        ],
                      ));
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        setState(() {
                          scrollPosition = _scrollController.offset;
                        });
                        if (_scrollController.position.extentAfter < 300 &&
                            state is ArticleLoaded &&
                            !(state).hasReachedEnd) {
                          context.read<ArticleBloc>().add(FetchMoreArticles());
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        onRefresh: () {
                          setState(() {
                            _selectedCategory = null;
                          });
                          return _refresh(context);
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: articles.length +
                              (state is ArticleLoaded && !state.hasReachedEnd
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            if (index >= articles.length) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return ArticleWidget(article: articles[index]);
                          },
                        ),
                      ),
                    );
                  } else if (state is ArticleError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ErrorLoadWidget(
                          message: state.message,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RefreshButtonWidget(
                          onTap: () {
                            setState(() {
                              _selectedCategory = null;
                            });
                            _refresh(context);
                          },
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _refresh(BuildContext context) async {
  context.read<ArticleBloc>().add(FetchArticles(null));
}
