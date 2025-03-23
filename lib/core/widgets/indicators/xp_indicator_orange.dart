import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/text/custom_text_rubik.dart';
import 'package:flutter/material.dart';

class XpIndicatorOrange extends StatelessWidget {
  const XpIndicatorOrange(
    this.xp, {
    super.key,
  });

  final int xp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/xp.png',
          height: 25,
        ),
        SizedBox(
          width: 2,
        ),
        CustomTextRubik(
            text: "$xp XP",
            weight: FontWeight.w700,
            size: 14,
            color: AppPalette.secondaryColor)
      ],
    );
  }
}
