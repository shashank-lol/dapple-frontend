import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTile extends StatelessWidget {
  const SectionTile(
      {super.key, required this.status, required this.title, required this.xp, required this.sectionNo});

  final LevelStatus status;
  final String title;
  final int xp;
  final int sectionNo;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return ListTile(
      horizontalTitleGap: 20,
      minTileHeight: deviceHeight/12,
      leading: Container(
        width: 40, // Diameter of the circle
        height: 40,
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
                  '$sectionNo',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
        ),
      ), // Icon at start
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: status == LevelStatus.locked
                ? AppPalette.section_title_color_off
                : AppPalette.section_title_color_on),
      ),
      subtitle: Text(
        "$xp XP",
        style: GoogleFonts.rubik(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppPalette.section_subtitle_color_off),
      ),
    );
  }
}
