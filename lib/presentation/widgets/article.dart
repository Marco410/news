import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:news/data/models/new_model.dart';
import 'package:news/presentation/views/article_detail_screen.dart';
import 'package:news/presentation/widgets/author_date.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer_pro/sizer.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: FadedScaleAnimation(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: ShadowStyle.generalShadow,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              (article.urlToImage != null)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Hero(
                        tag: article.title,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: article.urlToImage!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_rounded,
                              color: Colors.grey,
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              ListTile(
                title: Text(
                  article.title,
                  style: TxtStyle.labelStyle.copyWith(fontSize: 6.5.f),
                ),
                subtitle: Text(
                  (article.description != null)
                      ? "${article.description!.substring(0, 100)}..."
                      : "Ver más",
                  style: TxtStyle.labelStyle
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 5.5.f),
                ),
              ),
              const SizedBox(height: 10),
              AuthorAndDateArticleWidget(article: article),
            ],
          ),
        ),
      ),
    );
  }
}
