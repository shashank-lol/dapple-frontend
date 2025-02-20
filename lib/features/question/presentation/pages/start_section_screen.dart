import 'package:dapple/core/widgets/templates/section_start_template.dart';
import 'package:dapple/features/home/domain/entities/section.dart';
import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:dapple/features/question/presentation/bloc/xp/xp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_palette.dart';

class StartSectionScreen extends StatefulWidget {
  const StartSectionScreen(this.section, {required this.sectionId, super.key});

  final Section section;
  final String sectionId;

  @override
  State<StartSectionScreen> createState() => _StartSectionScreenState();
}

class _StartSectionScreenState extends State<StartSectionScreen> {
  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  Future<void> getQuestions() async {
    int xp =
        await context.read<QuestionsCubit>().loadQuestions(widget.sectionId);
    context.read<XpCubit>().resetXp(xp);
  }

  @override
  Widget build(BuildContext context) {
    return SectionStartTemplate(
      title: widget.section.title,
      description:
          "This section contains 4 lessons and 4 MCQ type questions. Earn at least 50 XP to clear this section.",
      sectionXp: widget.section.sectionXp,
      onTap: () {
        final questionsCubit = context.read<QuestionsCubit>();
        if (questionsCubit.state is QuestionsLoaded) {
          final questions = (questionsCubit.state as QuestionsLoaded).questions;
          debugPrint("CALLED");
          questionsCubit.getNextQuestion(context);
        }
      },
      bgColor: AppPalette.primaryColor,
      imagePath: "assets/dapple-girl/jump.png",
    );
  }
}
