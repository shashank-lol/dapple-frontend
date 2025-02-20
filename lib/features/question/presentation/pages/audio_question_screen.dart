import 'package:dapple/core/widgets/audio_recorder_widget.dart';
import 'package:dapple/core/widgets/back_button_handler.dart';
import 'package:dapple/features/question/presentation/widgets/questions_template_header.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_palette.dart';
import '../widgets/overlay_screens/loading.dart';
import '../widgets/question_template_screen.dart';

class AudioQuestionScreen extends StatefulWidget {
  const AudioQuestionScreen({super.key});

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
    print('\x1B[31m$filePath\x1B[0m');
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
    return BackButtonHandler(
      child: Stack(
        children: [
          QuestionTemplateScreen(
            buttonText: "Answer",
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
              mainAxisSize: MainAxisSize.min,
              children: [
                QuestionsTemplateHeader(title: 'Speak answer', action: () {}),
                AudioRecorderWidget(
                  onRecordingComplete: _handleRecordingComplete,
                  height: MediaQuery.of(context).size.height * 2 / 5,
                )
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
                    // _showOverlay!=_showOverlay;
                  });
                },
                child: LoadingOverlay(showOverlay: _showOverlay))
        ],
      ),
    );
  }
}
