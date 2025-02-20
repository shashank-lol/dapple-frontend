import 'package:dapple/core/widgets/back_button_handler.dart';
import 'package:dapple/features/question/presentation/widgets/overlay_screens/failure.dart';
import 'package:dapple/features/question/presentation/widgets/question_template_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../onboarding/presentation/bloc/option/option_bloc.dart';
import '../../../onboarding/presentation/widgets/options_button.dart';
import '../bloc/all_questions/questions_cubit.dart';
import '../bloc/question_complete/question_complete_bloc.dart';
import '../bloc/xp/xp_cubit.dart';
import '../widgets/overlay_screens/success.dart';

class ObjectiveQuestionScreen extends StatefulWidget {
  const ObjectiveQuestionScreen(
      {super.key,
      required this.options,
      required this.question,
      this.imageUrl,
      required this.questionId});

  final List<String> options;
  final String question;
  final String? imageUrl;
  final String questionId;

  @override
  State<ObjectiveQuestionScreen> createState() =>
      _ObjectiveQuestionScreenState();
}

class _ObjectiveQuestionScreenState extends State<ObjectiveQuestionScreen> {
  bool _showOverlay = false;

  Future<void> _receivedResponse(context) async {
    setState(() {
      _showOverlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonHandler(
      child: Stack(
        children: [
          QuestionTemplateScreen(
            buttonText: "Answer",
            widgetTop: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: widget.imageUrl == null
                              ? AssetImage(
                                  'assets/section/objective_img.png',
                                )
                              : NetworkImage(widget.imageUrl!),
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.question,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppPalette.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            widgetBottom:
                BlocListener<QuestionCompleteBloc, QuestionCompleteState>(
              listener: (context, state) {
                if (state is ObjectiveAnswered) {
                  _receivedResponse(context);
                }
              },
              child: Column(
                children: [
                  for (int i = 0; i < 4; i++)
                    BlocBuilder<QuestionCompleteBloc, QuestionCompleteState>(
                      builder: (context, state) {
                        bool? isCorrect;
                        if (state is ObjectiveAnswered) {
                          isCorrect = state
                                  .objectiveQuestionAnswer.correctOptionIndex ==
                              i;
                        }
                        return OptionsButton(
                            optionText: widget.options[i],
                            questionIndex: 1,
                            optionIndex: i,
                            maxSelection: 1,
                            isCorrect: isCorrect);
                      },
                    ),
                ],
              ),
            ),
            onTap: () {
              final responseBloc = context.read<QuestionCompleteBloc>();
              if (responseBloc.state is ObjectiveAnswered) {
                context
                    .read<XpCubit>()
                    .incrementXp((responseBloc.state as ObjectiveAnswered).xp);

                final questionsCubit = context.read<QuestionsCubit>();
                if (questionsCubit.state is QuestionsLoaded) {
                  responseBloc.add(QuestionResetEvent());
                  final optionsBloc = context.read<OptionBloc>();
                  optionsBloc.add(ResetOptions(maxSelection: 1));
                  questionsCubit.getNextQuestion(context);
                }
              } else if (responseBloc.state is CompletionLoading) {
                // Do nothing
              } else {
                final optionBloc = context.read<OptionBloc>().state;
                int selectedOption = optionBloc.selectedOptions[1][0];
                responseBloc.add(
                    ObjectiveAnsweredEvent(selectedOption, widget.questionId));
              }
            },
            resizeToAvoidBottomInset: false,
            buttonWidget:
                BlocBuilder<QuestionCompleteBloc, QuestionCompleteState>(
              builder: (context, state) {
                if (state is CompletionLoading) {
                  return Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppPalette.white,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                } else if (state is ObjectiveAnswered) {
                  return Text(
                    "continue".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppPalette.white),
                  );
                } else {
                  return Text(
                    "answer".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppPalette.white),
                  );
                }
              },
            ), theme: AppPalette.primaryColor,
          ),
          if (_showOverlay)
            BlocBuilder<QuestionCompleteBloc, QuestionCompleteState>(
              builder: (context, state) {
                if (state is ObjectiveAnswered) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          _showOverlay = !_showOverlay;
                        });
                      },
                      child: state.isCorrect
                          ? SuccessOverlay(
                              showOverlay: _showOverlay,
                              xp: state.xp,
                              description: "ye le description",
                            )
                          : FailureOverlay(
                              showOverlay: _showOverlay,
                              description: "ye le description",
                            ));
                } else {
                  return SizedBox();
                }
              },
            ),
        ],
      ),
    );
  }
}
