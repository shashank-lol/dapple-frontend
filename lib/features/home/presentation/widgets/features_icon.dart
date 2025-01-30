import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class FeaturesIcon extends StatelessWidget {
  const FeaturesIcon(this.assetName,{super.key});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [AppPalette.primaryShadow],
      ),
      child: Center(
        child: Image.asset(
          assetName,
          height: 44,
        ),
      ),
    );
  }
}
