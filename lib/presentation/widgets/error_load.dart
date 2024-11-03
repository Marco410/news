import 'package:flutter/material.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class ErrorLoadWidget extends StatelessWidget {
  final String message;
  const ErrorLoadWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_rounded,
          color: ColorStyle.errorColor,
          size: 17.f,
        ),
        const SizedBox(height: 5),
        Center(
            child: Text(message,
                style: TxtStyle.labelStyle.copyWith(
                  color: ColorStyle.errorColor,
                ))),
      ],
    );
  }
}
