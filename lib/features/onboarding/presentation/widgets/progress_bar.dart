import 'package:flutter/material.dart';

import '../../../../core/theme/app_palette.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, this.factor=1});

  final double factor;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final border = BorderSide(color: AppPalette.blackColor.withValues(alpha: 0.2) ,width: 2);
    final width = (deviceWidth / 1.5);
    return Stack(
      children: [
        Container(
          width: width,
          height: 20,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80),
              border: Border.fromBorderSide(border)
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
          width: width * factor,
          height: 20,
          decoration: BoxDecoration(
              color: AppPalette.primaryColor,
              borderRadius: BorderRadius.circular(80),
              border: Border.fromBorderSide(border)
          ),
        ),
      ],
    );
  }
}
