import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/back_button_handler.dart';
import 'package:dapple/features/question/presentation/widgets/overlay_screens/loading.dart';
import 'package:dapple/features/question/presentation/widgets/question_template_screen.dart';
import 'package:dapple/features/question/presentation/widgets/questions_template_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../bloc/question_complete/question_complete_bloc.dart';
import '../bloc/xp/xp_cubit.dart';

class SubjectiveQuestionScreen extends StatefulWidget {
  const SubjectiveQuestionScreen(
      {super.key,
      required this.question,
      required this.questionId,
      required this.maxXp});

  final String question;
  final String questionId;
  final int maxXp;

  @override
  State<SubjectiveQuestionScreen> createState() =>
      _SubjectiveQuestionScreenState();
}

class _SubjectiveQuestionScreenState extends State<SubjectiveQuestionScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _words = '';

  final TextEditingController _controller = TextEditingController();
  bool _showOverlay = false;

  void _receivedResponse(context) {
    setState(() {
      _showOverlay = true;
    });
  }

  @override
  void initState() {
    super.initState();
    final responseBloc = context.read<QuestionCompleteBloc>();
    responseBloc.add(SubjectiveAnswerHintEvent(widget.questionId));
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled =
        await _speechToText.initialize(finalTimeout: Duration(seconds: 2));
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _controller.text = result.recognizedWords;
    setState(() {
      _words = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionCompleteBloc, QuestionCompleteState>(
      listener: (context, state) {
        if (state is SubjectiveAnswered) {
          context
              .read<XpCubit>()
              .incrementXp(state.subjectiveQuestionAnswer.xp);
          GoRouter.of(context).pushReplacementNamed(AppRouteConsts.answerReport,
              extra: state.subjectiveQuestionAnswer,
              pathParameters: {'maxXp': widget.maxXp.toString()});
        }
      },
      child: BackButtonHandler(
        child: Stack(
          children: [
            QuestionTemplateScreen(
              buttonText: "Answer",
              widgetTop: Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Text(
                  textAlign: TextAlign.center,
                  widget.question,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              widgetBottom: Column(
                children: [
                  QuestionsTemplateHeader(
                      title: 'Answer',
                      action: () {
                        final responseBloc =
                            context.read<QuestionCompleteBloc>();
                        Dialogs.materialDialog(
                          context: context,
                          title: "Hint",
                          msg:
                              (responseBloc.state as SubjectiveAnswerHint).hint,
                          actionsBuilder: (context) {
                            return [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ];
                          },
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        // padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x266A5AE0), // Light purple background
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _controller,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppPalette.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "Type your answer or tap on the mic to speak",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Color(0x660C092A),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: ElevatedButton(
                          onPressed: _speechToText.isListening
                              ? _stopListening
                              : _startListening,
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            elevation: 4,
                            backgroundColor: Colors.white,
                            foregroundColor:
                                AppPalette.blackColor, // Icon color
                          ),
                          child: Icon(
                            _speechToText.isListening
                                ? Icons.mic
                                : Icons.mic_off,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                final responseBloc = context.read<QuestionCompleteBloc>();
                if (responseBloc.state is CompletionLoading) {
                  // Do nothing
                } else {
                  _receivedResponse(context);
                  final answer = _controller.text.trim();
                  // create string to list of string by adding new element after .
                  final listAnswer = answer.split('.').toList();
                  responseBloc.add(SubjectiveAnsweredEvent(
                      listAnswer, widget.questionId, widget.maxXp));
                }
              },
              resizeToAvoidBottomInset: false,
            ),
            if (_showOverlay)
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _showOverlay = !_showOverlay;
                    });
                    GoRouter.of(context)
                        .pushNamed(AppRouteConsts.objectiveQuestion);
                  },
                  child: LoadingOverlay(showOverlay: _showOverlay))
          ],
        ),
      ),
    );
  }
}
