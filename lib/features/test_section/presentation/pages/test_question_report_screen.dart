import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/back_button_handler.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/indicators/xp_arc_indicator.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';
import '../widgets/report_tile.dart';

class TestQuestionReportScreen extends StatelessWidget {
  const TestQuestionReportScreen({super.key});

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
                          text: 'QUESTION 1',
                          weight: FontWeight.w600,
                          size: 20,
                          color: AppPalette.blackColor),
                      Text(
                        "Write the best response for a colleague asking about your weekend.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppPalette.blackColor,
                        ),
                      ),
                      XpArcIndicator(
                        progress: 50,
                        max: 100,
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
                                for (int i = 0; i < 2; i++)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRubik(
                                          text: "✅ Best Traits",
                                          weight: FontWeight.w700,
                                          size: 14,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
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
                      for (int i = 0; i < 5; i++)
                        ReportTile(
                            title: "Question ${i + 1}",
                            description:
                                "Write the best response for a colleague asking about your weekend.",
                            xpGained: 20,
                            totalXp: 100, type: 2,)
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
