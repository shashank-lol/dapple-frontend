import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/test_section/presentation/bloc/test_questions/test_questions_cubit.dart';
import 'package:dapple/features/test_section/presentation/widgets/video_recorder.dart';
import 'package:flutter/foundation.dart';
import 'package:dapple/features/test_section/domain/entities/test_question.dart';
import 'package:dapple/features/test_section/presentation/bloc/socket/socket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_route_consts.dart';
import '../widgets/test_template_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestQuestionScreen extends StatefulWidget {
  const TestQuestionScreen(
      {super.key, required this.question, required this.sessionId, required this.sectionId});

  final TestQuestion question;
  final String sessionId;
  final String sectionId;

  @override
  State<TestQuestionScreen> createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends State<TestQuestionScreen> {
  String _answer = "";
  String _path = "";

  void _onSpeechResult(String ans) {
    setState(() {
      _answer = ans;
    });
    if (kDebugMode) {
      print(_answer);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<SocketBloc>().add(InitSocketEvent());
  }

  bool reload = false;

  @override
  Widget build(BuildContext context) {
    return TestTemplateScreen(
        widgetTop: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: SingleChildScrollView(
            child: Text(
              textAlign: TextAlign.center,
              widget.question.question,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        // widgetBottom: SpeechToTextWidget(onTextChanged: _onSpeechResult),
        widgetBottom: VideoRecorder(
          onDataReceived: _onSpeechResult,
          questionId: widget.question.questionId,
          sessionId: widget.sessionId,
          reload: reload,
          child: _answer.isNotEmpty
              ?
              // show user their answer
              Expanded(
                  child: Text("Your Answer - $_answer",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppPalette.blackColor)))
              :
              // base case
              Expanded(
                  child: Text("Tap on START to record your answer",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppPalette.blackColor))),
        ),
        onTap: () {
          if (_answer.isEmpty) {
            // show snackbar
            SnackBar snackBar = SnackBar(
              content: Text('Please answer the question'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
          Future.delayed(Duration.zero, () async {
            setState(() {
              reload = true;
              _answer = "";
            });
          });
          context.read<SocketBloc>().add(SendAnswerEvent(
              _answer, widget.question.questionId, widget.sessionId));
          final questionsCubit = context.read<TestQuestionsCubit>();
          int index = questionsCubit.getNextQuestionIndex();
          if (index ==
              (questionsCubit.state as TestQuestionsLoaded).questions.length -
                  1) {
            GoRouter.of(context).pushReplacementNamed(
              AppRouteConsts.testReportScreen,
              extra: {
                'sessionId':
                    (questionsCubit.state as TestQuestionsLoaded).sessionId,
                'sectionId': widget.sectionId
              },
            );
            return;
          }
          GoRouter.of(context).pushReplacementNamed(
              AppRouteConsts.testQuestionScreen,
              extra: (questionsCubit.state as TestQuestionsLoaded)
                  .questions[index + 1],
              pathParameters: {
                'sessionId':
                    (questionsCubit.state as TestQuestionsLoaded).sessionId,
                'sectionId': widget.sectionId
              });
        },
        resizeToAvoidBottomInset: false,
        buttonText: "Continue");
  }
}
