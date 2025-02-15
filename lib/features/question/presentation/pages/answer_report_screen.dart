import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/back_button_handler.dart';
import 'package:dapple/core/widgets/text/custom_text_rubik.dart';
import 'package:dapple/core/widgets/buttons/primary_button.dart';
import 'package:dapple/features/question/domain/entities/subjective_question_answer.dart';
import 'package:dapple/features/question/presentation/widgets/section_progress_bar.dart';
import 'package:dapple/core/widgets/indicators/xp_arc_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/all_questions/questions_cubit.dart';
import '../bloc/question_complete/question_complete_bloc.dart';

class AnswerReportScreen extends StatefulWidget {
  const AnswerReportScreen(
      {super.key, required this.maxXp, required this.response});

  final int maxXp;
  final SubjectiveQuestionAnswer response;

  @override
  State<AnswerReportScreen> createState() => _AnswerReportScreenState();
}

class _AnswerReportScreenState extends State<AnswerReportScreen> {
  bool isAnswerExpanded = false;

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
                        progress: widget.response.xp,
                        max: widget.maxXp,
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
                                for (int i = 0;
                                    i < widget.response.evaluations.length;
                                    i++)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRubik(
                                          text: widget
                                              .response.evaluations[i].title,
                                          weight: FontWeight.w700,
                                          size: 14,
                                          color: Colors.black),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        widget.response.evaluations[i].content,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppPalette.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [AppPalette.secondaryShadow]),
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
                                Text(
                                  widget.response.bestAnswer.join('\n'),
                                  style: GoogleFonts.rubik(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppPalette.white,
                                    height: 1.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFD8D4F7),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [AppPalette.secondaryShadow]),
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
                                  overflow: isAnswerExpanded
                                      ? null
                                      : TextOverflow.ellipsis,
                                  maxLines: isAnswerExpanded ? null : 2,
                                  widget.response.userAnswer.join('\n'),
                                  style: GoogleFonts.rubik(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppPalette.blackColor,
                                    height: 1.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrimaryButton(
                    onTap: () {
                      final questionsCubit = context.read<QuestionsCubit>();
                      if (questionsCubit.state is QuestionsLoaded) {
                        final responseBloc = context.read<QuestionCompleteBloc>();
                        responseBloc.add(QuestionResetEvent());
                        questionsCubit.getNextQuestion(context);
                      }
                    },
                    text: 'CONTINUE',
                    primaryColor: AppPalette.white,
                    bgColor: AppPalette.primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
