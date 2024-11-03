import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../data/config/theme/style.dart';
import '../../data/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.onTap,
    required this.selected,
  });

  final CategoryModel category;
  final Function? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap as void Function(),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            color: (selected) ? ColorStyle.primaryColor : ColorStyle.blueLight,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          category.name,
          style: TxtStyle.labelStyle
              .copyWith(color: (selected) ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
