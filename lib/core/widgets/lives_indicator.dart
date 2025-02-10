import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_palette.dart';

class LivesIndicator extends StatelessWidget {
  const LivesIndicator({super.key, required this.lightTheme});

  final bool lightTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/live.svg',
          height: 30,
        ),
        SizedBox(
          width: 6,
        ),
        Text("3",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: lightTheme ? AppPalette.white : AppPalette.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16))
      ],
    );
  }
}
