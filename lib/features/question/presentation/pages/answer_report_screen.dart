import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/custom_text_rubik.dart';
import 'package:dapple/core/widgets/primary_button.dart';
import 'package:dapple/features/question/presentation/widgets/section_progress_bar.dart';
import 'package:dapple/features/question/presentation/widgets/xp_arc_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnswerReportScreen extends StatefulWidget {
  const AnswerReportScreen({super.key});

  @override
  State<AnswerReportScreen> createState() => _AnswerReportScreenState();
}

class _AnswerReportScreenState extends State<AnswerReportScreen> {
  bool isAnswerExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppPalette.white,
          image: DecorationImage(
              image: AssetImage('assets/section/image_bg_light.png')),
        ),
        child: Column(
          children: [
            SectionProgressBar(lightThemeBarEnabled: false),
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
                      progress: 85,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppPalette.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                            child: Column(
                              children: [
                                for (int i = 0; i < 2; i++)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextRubik(
                                          text: 'Concepts to Focus',
                                          weight: FontWeight.w700,
                                          size: 14,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomTextRubik(
                                          text:
                                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                          weight: FontWeight.w400,
                                          size: 14,
                                          color: Color(0xFF0C092A)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppPalette.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextRubik(
                                    text: 'Recommended Answer',
                                    weight: FontWeight.w700,
                                    size: 14,
                                    color: AppPalette.white),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextRubik(
                                    text:
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.\n'
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.\n'
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                    weight: FontWeight.w400,
                                    size: 14,
                                    color: AppPalette.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFD8D4F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomTextRubik(
                                        text: 'Your Answer',
                                        weight: FontWeight.w700,
                                        size: 14,
                                        color: Colors.black),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isAnswerExpanded = !isAnswerExpanded;
                                        });
                                      },
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: SvgPicture.asset(isAnswerExpanded
                                            ? 'assets/section/close.svg'
                                            : 'assets/section/open.svg'),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  overflow: isAnswerExpanded?null:TextOverflow.ellipsis,
                                  maxLines: isAnswerExpanded?null:2,
                                  ' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Color(0xFF0C092A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                  bgColor: AppPalette.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
