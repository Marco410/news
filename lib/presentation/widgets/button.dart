import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class ButtonWidget extends StatelessWidget {
  final Function onTap;
  final String text;

  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap as void Function(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        decoration: BoxDecoration(
            color: ColorStyle.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TxtStyle.labelStyle
              .copyWith(color: Colors.white, fontSize: 6.5.f),
        ),
      ),
    );
  }
}
