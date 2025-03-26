import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/features/home/domain/entities/section.dart';
import 'package:dapple/features/test_section/presentation/bloc/test_questions/test_questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/templates/section_start_template.dart';

class StartTestScreen extends StatefulWidget {
  const StartTestScreen({super.key, required this.section});

  final Section section;

  @override
  State<StartTestScreen> createState() => _StartTestScreenState();
}

class _StartTestScreenState extends State<StartTestScreen> {
  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  void getQuestions() async {
    await context
        .read<TestQuestionsCubit>()
        .loadQuestions(widget.section.sectionId);
  }

  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TestQuestionsCubit, TestQuestionsState>(
      listener: (context, state) {
        if (isTap) {
          if (state is TestQuestionsLoaded) {
            final questionsCubit = context.read<TestQuestionsCubit>();
            GoRouter.of(context).pushNamed(AppRouteConsts.testQuestionScreen,
                extra:
                    (questionsCubit.state as TestQuestionsLoaded).questions[0],
                pathParameters: {
                  'sessionId':
                      (questionsCubit.state as TestQuestionsLoaded).sessionId,
                  'sectionId': widget.section.sectionId
                });
            setState(() {
              isTap = false;
            });
          }
        }
      },
      child: SectionStartTemplate(
        title: widget.section.title,
        description: widget.section.description,
        sectionXp: widget.section.sectionXp,
        bgColor: AppPalette.secondaryColor,
        imagePath: "assets/dapple-girl/girl_with_pencil.png",
        onTap: () {
          setState(() {
            isTap = true;
          });
          final questionsCubit = context.read<TestQuestionsCubit>();
          if (questionsCubit.state is TestQuestionsLoaded) {
            GoRouter.of(context).pushNamed(AppRouteConsts.testQuestionScreen,
                extra:
                    (questionsCubit.state as TestQuestionsLoaded).questions[0], pathParameters: {
                  'sessionId':
                  (questionsCubit.state as TestQuestionsLoaded).sessionId,
                  'sectionId': widget.section.sectionId
                });
          }
        },
        child: isTap
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppPalette.secondaryColor,
                    strokeWidth: 2,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
