import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionTile extends StatelessWidget {
  const SectionTile(
      {super.key, required this.status, required this.currentsection});

  final LevelStatus status;
  final int currentsection;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 25,
      leading: Container(
        width: 50, // Diameter of the circle
        height: 50,
        decoration: BoxDecoration(
          color: status == LevelStatus.locked
              ? AppPalette.icon_bgcolor_off
              : AppPalette.icon_bgcolor_on, // Background color
          shape: BoxShape.circle, // Makes the container circular
        ),
        child: Center(
          child: status == LevelStatus.completed
              ? SvgPicture.asset(
                  'assets/icons/tick.svg',
                  height: 30,
                )
              : Text(
                  '$currentsection',
                  style: TextStyle(color: AppPalette.white,
                  fontSize: 16),
                ),
        ),
      ), // Icon at start
      title: Text(
        "What to Speak?",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: status == LevelStatus.locked
                ? AppPalette.section_title_color_off
                : AppPalette.section_title_color_on),
      ),
      subtitle: Text(
        "20 XP",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: AppPalette.section_subtitle_color_off),
      ),
    );
  }
}
