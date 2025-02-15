import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class XpIndicator extends StatelessWidget {
  const XpIndicator(this.xp,{super.key, });

  final int xp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/xp.png',
          height: 30,
        ),
        SizedBox(
          width: 2,
        ),
        Text("$xp",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppPalette.white, fontWeight: FontWeight.w600,fontSize: 16))
      ],
    );
  }
}
