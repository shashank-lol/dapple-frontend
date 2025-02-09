import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/custom_text_rubik.dart';
import 'package:dapple/core/widgets/question_template_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SubjectiveQuestionScreen extends StatefulWidget {
  const SubjectiveQuestionScreen({super.key});

  @override
  State<SubjectiveQuestionScreen> createState() => _SubjectiveQuestionScreenState();
}

class _SubjectiveQuestionScreenState extends State<SubjectiveQuestionScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _words = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
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
    return QuestionTemplateScreen(
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
            Row(
              children: [
                CustomTextRubik(
                    text: 'Answer',
                    weight: FontWeight.w600,
                    size: 20,
                    color: AppPalette.blackColor),
                Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/section/bulb.svg',
                      height: 20,
                    ),
                    Text(
                      'Reveal Best Answer',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Color(0xFF3629B7),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                    ),
                  ],
                )
              ],
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
                      _speechToText.isListening ? Icons.mic_off : Icons.mic,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
