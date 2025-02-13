import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/question/presentation/widgets/overlay_screens/loading.dart';
import 'package:dapple/features/question/presentation/widgets/question_template_screen.dart';
import 'package:dapple/features/question/presentation/widgets/questions_template_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../core/routes/app_route_consts.dart';

class SubjectiveQuestionScreen extends StatefulWidget {
  const SubjectiveQuestionScreen({super.key});

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

    // Wait for 5 seconds, then navigate to the next page
    Future.delayed(Duration(seconds: 1), () {
      if (_showOverlay == true) {
        GoRouter.of(context).pushNamed(AppRouteConsts.objectiveQuestionScreen);
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
    _controller.text += result.recognizedWords;
    setState(() {
      _words = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QuestionTemplateScreen(
          widgetTop: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Write the best response for a colleague asking about your weekend.',
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
                action: () {},
              ),
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
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppPalette.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type your answer or tap on the mic to speak",
                        hintStyle:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
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
                        foregroundColor: AppPalette.blackColor, // Icon color
                      ),
                      child: Icon(
                        _speechToText.isListening ? Icons.mic : Icons.mic_off,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            _receivedResponse(context);
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
                    .pushNamed(AppRouteConsts.objectiveQuestionScreen);
              },
              child: LoadingOverlay(showOverlay: _showOverlay))
      ],
    );
  }
}
