import 'package:dapple/features/question/presentation/widgets/question_template_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_route_consts.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../onboarding/presentation/widgets/options_button.dart';

class ObjectiveQuestionScreen extends StatelessWidget {
  const ObjectiveQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Option1', 'Option 2', 'Option 3', 'Option 4'];
    return QuestionTemplateScreen(
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
                    image: AssetImage(
                      'assets/section/objective_img.png',
                    ),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Text(
              textAlign: TextAlign.center,
              'How is the girl feeling while talking with fish_n_chips?',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      widgetBottom: Column(
        children: [
          for (int i = 0; i < 4; i++)
            OptionsButton(
              optionText: options[i],
              questionIndex: 1,
              optionIndex: i,
              maxSelection: 1,
            ),
        ],
      ),
      onTap: () {
        GoRouter.of(context)
            .pushNamed(AppRouteConsts.audioQuestionScreen);
      }, resizeToAvoidBottomInset: false,
    );
  }
}
