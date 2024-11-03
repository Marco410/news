import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:news/data/models/new_model.dart';
import 'package:news/presentation/widgets/author_date.dart';
import 'package:news/presentation/widgets/button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text(
                article.title,
                style: TxtStyle.headerStyle,
              ),
              const SizedBox(height: 10),
              Text(
                (article.description != null) ? article.description! : "",
                style:
                    TxtStyle.labelStyle.copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(height: 10),
              AuthorAndDateArticleWidget(article: article),
              const SizedBox(height: 20),
              ButtonWidget(
                onTap: () async {
                  final Uri url = Uri.parse(article.url);
                  launchUrl(url, mode: LaunchMode.inAppBrowserView);
                },
                text: "Leer más",
              )
            ],
          ),
        ),
      ),
    );
  }
}
