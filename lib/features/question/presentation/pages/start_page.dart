import 'package:dapple/core/widgets/buttons/primary_button.dart';
import 'package:dapple/features/home/domain/entities/section.dart';
import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_palette.dart';

class StartPage extends StatefulWidget {
  const StartPage(this.section, {super.key});

  final Section section;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  void getQuestions() async {
    await context
        .read<QuestionsCubit>()
        .loadQuestions(widget.section.sectionId);
  }

  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return BlocListener<QuestionsCubit, QuestionsState>(
      listener: (context, state) {
        if (isTap && state is QuestionsLoaded) {
          final questionsCubit = context.read<QuestionsCubit>();
          questionsCubit.getNextQuestion(context);
          setState(() {
            isTap = false;
          });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image_bg.png"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(AppPalette.primaryColor, BlendMode.color)),
          ),
          child: SafeArea(
            minimum: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: deviceHeight / 10,
                ),
                Center(
                    child: Image.asset(
                  "assets/dapple-girl/jump.png",
                  height: deviceHeight / 3,
                )),
                const SizedBox(height: 24),
                Text(
                  widget.section.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.white),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.section.description,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppPalette.white.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w300),
                ),
                const Spacer(),
                PrimaryButton(
                  onTap: () {
                    setState(() {
                      isTap = true;
                    });
                    final questionsCubit = context.read<QuestionsCubit>();
                    if (questionsCubit.state is QuestionsLoaded) {
                      questionsCubit.getNextQuestion(context);
                    }
                  },
                  text: "Start +${widget.section.sectionXp} XP",
                  primaryColor: AppPalette.primaryColor,
                  bgColor: Colors.white,
                  child: isTap
                      ? const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppPalette.primaryColor,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
