import 'dart:io';

import 'package:dapple/core/cubits/xp/xp_cubit.dart';
import 'package:dapple/core/widgets/audio_recorder_widget.dart';
import 'package:dapple/core/widgets/back_button_handler.dart';
import 'package:dapple/features/question/domain/entities/subjective_question_answer.dart';
import 'package:dapple/features/question/presentation/bloc/question_complete/question_complete_bloc.dart';
import 'package:dapple/features/question/presentation/widgets/questions_template_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_route_consts.dart';
import '../../../../core/theme/app_palette.dart';
import '../widgets/overlay_screens/loading.dart';
import '../widgets/question_template_screen.dart';

class AudioQuestionScreen extends StatefulWidget {
  const AudioQuestionScreen(
      {super.key, required this.question, required this.maxXp, required this.questionId});

  final String question;
  final int maxXp;
  final String questionId;

  @override
  State<AudioQuestionScreen> createState() => _AudioQuestionScreenState();
}

class _AudioQuestionScreenState extends State<AudioQuestionScreen>
    with SingleTickerProviderStateMixin {
  bool _showOverlay = false;
  String? audioFilePath;

  void _handleRecordingComplete(String? filePath) {
    setState(() {
      audioFilePath = filePath;
    });
    print(audioFilePath);
  }

  void _receivedResponse(context) {
    setState(() {
      _showOverlay = true;
    });

    // Wait for 5 seconds, then navigate to the next page
    Future.delayed(Duration(seconds: 1), () {
      if (_showOverlay == true) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionCompleteBloc, QuestionCompleteState>(
      listener: (context, state) {
        if (state is VoiceAnswered) {
          setState(() {
            _showOverlay = false;
          });
          context.read<XpCubit>().incrementXp(state.voiceAnswer.xp);
          GoRouter.of(context).pushReplacementNamed(AppRouteConsts.answerReport,
              extra: SubjectiveQuestionAnswer(
                  evaluations: state.voiceAnswer.evaluation,
                  bestAnswer: [""],
                  xp: state.voiceAnswer.xp,
                  userAnswer: [""]),
              pathParameters: {'maxXp': widget.maxXp.toString()});
        }
        if(state is QuestionCompleteError){
          setState(() {
            _showOverlay = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: Duration(seconds: 2),
          ));
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                      color: AppPalette.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              widgetBottom: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuestionsTemplateHeader(title: 'Speak answer', action: () {}),
                  AudioRecorderWidget(
                    onRecordingComplete: _handleRecordingComplete,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 2 / 5,
                  )
                ],
              ),
              onTap: () async {
                if (audioFilePath == null) {
                  debugPrint("No audio file recorded");
                  return;
                }
                print(audioFilePath);
                File file = File(audioFilePath ?? "");
                final responseBloc = BlocProvider.of<QuestionCompleteBloc>(
                    context);
                responseBloc.add(
                    VoiceAnsweredEvent(file, widget.questionId, widget.maxXp));
                _receivedResponse(context);
              },
              resizeToAvoidBottomInset: false,
            ),
            if (_showOverlay)
              GestureDetector(
                  onTap: () {
                    setState(() {
                      // _showOverlay!=_showOverlay;
                    });
                  },
                  child: LoadingOverlay(showOverlay: _showOverlay))
          ],
        ),
      ),
    );
  }
}
