import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/templates/section_start_template.dart';

class StartTestScreen extends StatelessWidget {
  const StartTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionStartTemplate(
      title: "How to Speak ?",
      description:
          "This section contains 4 lessons and 4 MCQ type questions. Earn at least 50 XP to clear this section.",
      sectionXp: 100,
      bgColor: AppPalette.secondaryColor,
      imagePath: "assets/dapple-girl/girl_with_pencil.png",
      onTap: () {
        GoRouter.of(context).pushNamed(AppRouteConsts.testQuestionScreen);
      },
    );
  }
}
