import 'package:dapple/features/test_section/domain/entities/question_result.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/back_button_handler.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/indicators/xp_arc_indicator.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';
import '../widgets/report_tile.dart';

class TestQuestionReportScreen extends StatelessWidget {
  const TestQuestionReportScreen(
      {super.key,
      required this.question,
      required this.questionResult,
      required this.maxXp});

  final String question;
  final int maxXp;
  final QuestionResult questionResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackButtonHandler(
        child: Container(
          decoration: BoxDecoration(
            color: AppPalette.white,
            image: DecorationImage(
                image: AssetImage('assets/section/image_bg_light.png')),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextRubik(
                          text: 'QUESTION REPORT',
                          weight: FontWeight.w600,
                          size: 20,
                          color: AppPalette.blackColor),
                      Text(
                        question,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppPalette.blackColor,
                        ),
                      ),
                      XpArcIndicator(
                        progress: questionResult.obtainedXp,
                        max: maxXp,
                        color: AppPalette.secondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppPalette.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [AppPalette.secondaryShadow]),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var evaluation
                                    in questionResult.evaluations)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRubik(
                                          text: evaluation.title,
                                          weight: FontWeight.w700,
                                          size: 14,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        evaluation.description,
                                        style: GoogleFonts.rubik(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppPalette.blackColor,
                                          height: 1.25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      for (var summary in questionResult.summaries)
                        ReportTile(
                          title: summary.title,
                          description: summary.content,
                          xpGained: summary.userScore,
                          totalXp: summary.totalScore,
                          type: 2,
                        )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrimaryButton(
                    onTap: () {},
                    text: 'CONTINUE',
                    primaryColor: AppPalette.white,
                    bgColor: AppPalette.secondaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
