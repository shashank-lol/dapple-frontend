import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/text/custom_text_rubik.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routes/app_route_consts.dart';

class ReportTile extends StatelessWidget {
  const ReportTile(
      {super.key,
      required this.title,
      required this.description,
      required this.xpGained,
      required this.totalXp,
      required this.type});

  final String title;
  final String description;
  final int xpGained;
  final int totalXp;
  final int type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppRouteConsts.testQuestionReportScreen);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [AppPalette.secondaryShadow],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      value: xpGained / totalXp,
                      // 75% completion
                      strokeWidth: 6,
                      color: AppPalette.secondaryColor,
                      backgroundColor: Color(0xFFFFD7BD),
                    ),
                  ),
                  type == 1
                      ? Text(
                          "$xpGained XP",
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppPalette.blackColor),
                        )
                      : Text(
                          "$xpGained/$totalXp",
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppPalette.blackColor),
                        )
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextRubik(
                        text: title,
                        weight: FontWeight.w600,
                        size: 16,
                        color: AppPalette.secondaryColor),
                    SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppPalette.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
