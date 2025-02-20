import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/question/presentation/widgets/question_template_screen.dart';
import 'package:flutter/material.dart';

class TestQuestionScreen extends StatelessWidget {
  const TestQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionTemplateScreen(
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
        widgetBottom: Container(),
        onTap: () {},
        resizeToAvoidBottomInset: false,
        buttonText: "Continue",
        theme: AppPalette.secondaryColor);
  }
}
