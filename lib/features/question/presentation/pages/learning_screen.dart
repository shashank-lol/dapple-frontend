import 'package:dapple/core/utils/back_button_handler.dart';
import 'package:dapple/features/question/presentation/widgets/section_progress_bar.dart';
import 'package:dapple/features/question/presentation/widgets/overlay_screens/success.dart';
import 'package:dapple/features/question/presentation/bloc/question_complete/question_complete_bloc.dart';
import 'package:dapple/features/question/presentation/bloc/xp/xp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/primary_button.dart';
import '../bloc/all_questions/questions_cubit.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen(
      {super.key,
      this.imageUrl,
      required this.title,
      required this.content,
      required this.lessonId,
      required this.lessonXp});

  final String? imageUrl;
  final String title;
  final List<String> content;
  final String lessonId;
  final int lessonXp;

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with SingleTickerProviderStateMixin {
  bool _showOverlay = false;

  Future<void> _completeReading(context) async {
    setState(() {
      _showOverlay = true;
    });

    // Wait for 5 seconds, then navigate to the next page
    await Future.delayed(Duration(seconds: 1), () {
      if (_showOverlay == true) {
        _showOverlay = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BackButtonHandler(
        child: Stack(
          children: [
            Column(
              children: [
                ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0x99000000), Colors.transparent],
                        // Dark to Transparent
                        begin: Alignment.topCenter,
                        // Dark on the left side
                        end: Alignment.center, // Transparent on the right side
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.darken, // Darkening effect
                    child: widget.imageUrl == null
                        ? Image.asset(
                            'assets/section/learning_bg.png',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.imageUrl!,
                            fit: BoxFit.cover,
                          )),
              ],
            ),
            Column(
              children: [
                SectionProgressBar(
                  lightThemeBarEnabled: true,
                ),
                Spacer(),
                Container(
                  // Adjust width as needed
                  height: MediaQuery.of(context).size.height *
                      3 /
                      5, // Adjust height as needed
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ), // Border radius 20
                    image: DecorationImage(
                      image: AssetImage("assets/section/image_bg_white.png"),
                      // Your background image
                      fit: BoxFit.cover, // Covers the container
                    ),
                  ),
                  child: SafeArea(
                    minimum: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppPalette.learningTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    height: 1.2,
                                  ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SingleChildScrollView(
                          child: Text(
                            widget.content.join("\n"),
                            style: GoogleFonts.rubik(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppPalette.learningTextColor),
                          ),
                        ),
                        Spacer(),
                        const SizedBox(
                          height: 8,
                        ),
                        PrimaryButton(
                            onTap: () async {
                              final responseBloc =
                                  context.read<QuestionCompleteBloc>();
                              responseBloc
                                  .add(LessonCompletedEvent(widget.lessonId));
                              await _completeReading(context);
                              if (responseBloc.state is LessonCompleted) {
                                context
                                    .read<XpCubit>()
                                    .incrementXp(widget.lessonXp);
                                final questionsCubit =
                                    context.read<QuestionsCubit>();
                                if ((questionsCubit.state is QuestionsLoaded) &&
                                    !_showOverlay) {
                                  responseBloc.add(QuestionResetEvent());
                                  questionsCubit.getNextQuestion(context);
                                }
                              }
                            },
                            text: "Continue",
                            primaryColor: AppPalette.white,
                            bgColor: AppPalette.primaryColor),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showOverlay)
              BlocBuilder<QuestionCompleteBloc, QuestionCompleteState>(
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () {
                        if (state is LessonCompleted) {
                          setState(() {
                            _showOverlay = !_showOverlay;
                          });
                        }
                      },
                      child: SuccessOverlay(
                        showOverlay: _showOverlay,
                        xp: widget.lessonXp,
                      ));
                },
              )
          ],
        ),
      ),
    );
  }
}
