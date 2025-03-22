import 'package:dapple/features/test_section/presentation/widgets/report_tile.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/back_button_handler.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/indicators/xp_arc_indicator.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';

class TestReportScreen extends StatelessWidget {
  const TestReportScreen({super.key});

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
                          text: 'ANSWER REPORT',
                          weight: FontWeight.w600,
                          size: 20,
                          color: AppPalette.blackColor),
                      XpArcIndicator(
                        progress: 50,
                        max: 100,
                        color: AppPalette.secondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomTextRubik(
                              text: "Here is the question wise report - ",
                              weight: FontWeight.w400,
                              size: 14,
                              color: AppPalette.blackColor),
                        ),
                      ),
                      for (int i = 0; i < 5; i++)
                        ReportTile(
                            title: "Question ${i + 1}",
                            description:
                                "Write the best response for a colleague asking about your weekend.",
                            xpGained: 20,
                            totalXp: 100, type: 1,)
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
