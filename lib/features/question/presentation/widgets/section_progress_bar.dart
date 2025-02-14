import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/lives_indicator.dart';

class SectionProgressBar extends StatelessWidget {
  const SectionProgressBar({super.key, required this.lightThemeBarEnabled});

  final bool lightThemeBarEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 36, 18, 18),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                'assets/section/cross.svg',
                colorFilter: ColorFilter.mode(
                    lightThemeBarEnabled
                        ? AppPalette.white
                        : AppPalette.blackColor,
                    BlendMode.srcIn),
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: BlocBuilder<QuestionsCubit, QuestionsState>(
              builder: (context, state) {
                final progress = (state as QuestionsLoaded).currentIndex /
                    (state).questions.length;
                return LinearProgressIndicator(
                  value: progress,
                  // 50% progress
                  backgroundColor: AppPalette.progressBarColor,
                  // Background color
                  color: lightThemeBarEnabled
                      ? AppPalette.white
                      : AppPalette.primaryColor,
                  // Progress color
                  minHeight: 8,
                  // Thickness of the bar
                  borderRadius: BorderRadius.circular(4), // Rounded corners
                );
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          LivesIndicator(
            lightTheme: lightThemeBarEnabled,
          ),
        ],
      ),
    );
  }
}
