import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/data/config/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class RefreshButtonWidget extends StatelessWidget {
  final Function onTap;
  const RefreshButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap as void Function(),
      child: Container(
        width: 50.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorStyle.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Actualizar",
              style: TxtStyle.labelStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.refresh_rounded,
              size: 10.f,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
