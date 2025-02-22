import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/test_section/presentation/widgets/speech_to_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';
import '../widgets/test_template_screen.dart';

class TestQuestionScreen extends StatefulWidget {
  const TestQuestionScreen({super.key});

  @override
  State<TestQuestionScreen> createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends State<TestQuestionScreen> {
  String _answer = "";

  void _onSpeechResult(String result) {
    setState(() {
      _answer = result;
    });
    if (kDebugMode) {
      print(_answer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TestTemplateScreen(
        widgetTop: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Text(
            textAlign: TextAlign.center,
            "Write the best response for a colleague asking about your weekend.",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppPalette.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        widgetBottom: SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextRubik(
                  text: "Add answer",
                  weight: FontWeight.w600,
                  size: 20,
                  color: AppPalette.blackColor),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  // padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE1CC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: _answer == ""
                          ? Opacity(
                            opacity: 0.4,
                            child: Text(
                                "Tap the mic to start speaking",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppPalette.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                          )
                          : Text(
                              _answer,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppPalette.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                    ),
                  ),
                ),
              ),
              SpeechToTextWidget(onTextChanged: _onSpeechResult),
            ],
          ),
        ),
        onTap: () {},
        resizeToAvoidBottomInset: false,
        buttonText: "Continue");
  }
}
