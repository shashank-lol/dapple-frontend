import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/levelstatus.dart';

class LevelStatusIcon extends StatelessWidget {
  const LevelStatusIcon({super.key, required this.status});

  final LevelStatus status;

  // Function to get the icon based on the LevelStatus
  IconData getStatusIconData(LevelStatus status) {
    if (status == LevelStatus.current) {
      return Icons.play_circle_fill; // Icon for current level
    } else if (status == LevelStatus.completed) {
      return Icons.check_circle; // Icon for completed level
    } else if (status == LevelStatus.locked) {
      return Icons.lock; // Icon for locked level
    } else {
      return Icons.error; // Default error icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppPalette.white,
            width: 1,
          ),
          color: AppPalette.transparent,
        ),
        child: Icon(getStatusIconData(status),color: AppPalette.white,));
  }
}
