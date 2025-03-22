import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/test_section/presentation/widgets/video_recorder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_route_consts.dart';
import '../widgets/test_template_screen.dart';

class TestQuestionScreen extends StatefulWidget {
  const TestQuestionScreen({super.key});

  @override
  State<TestQuestionScreen> createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends State<TestQuestionScreen> {
  String _answer = "";
  String _path="";

  void _onSpeechResult(String ans,String photosPath) {
    setState(() {
      _answer = ans;
      _path=photosPath;
    });
    if (kDebugMode) {
      print(_answer);
      print(_path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TestTemplateScreen(
        widgetTop: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: SingleChildScrollView(
            child: Text(
              textAlign: TextAlign.center,
              "Write the best response for a colleague asking about your weekend.",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        // widgetBottom: SpeechToTextWidget(onTextChanged: _onSpeechResult),
        widgetBottom: VideoRecorder(onDataReceived: _onSpeechResult,),
        onTap: () {
          GoRouter.of(context).pushNamed(AppRouteConsts.testReportScreen);
        },
        resizeToAvoidBottomInset: false,
        buttonText: "Continue");
  }
}
