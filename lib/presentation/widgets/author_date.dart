import 'package:flutter/material.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:news/data/helpers/base_helper.dart';
import 'package:news/data/models/new_model.dart';

class AuthorAndDateArticleWidget extends StatelessWidget {
  const AuthorAndDateArticleWidget({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.person_rounded,
              color: ColorStyle.primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              article.author ?? 'anonymous',
              style: TxtStyle.labelStyle,
            )
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              color: ColorStyle.primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              HelperDate.formatDateyMMMd(article.publishedAt),
              style: TxtStyle.labelStyle,
            ),
          ],
        ),
      ],
    );
  }
}
