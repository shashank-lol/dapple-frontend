import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class FeaturesIcon extends StatelessWidget {
  const FeaturesIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [AppPalette.primaryShadow],
      ),
      child: Center(
        child: Image.asset(
          "assets/features/chat.png",
          height: 40,
        ),
      ),
    );
  }
}
