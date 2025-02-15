import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/indicators/lives_indicator.dart';

class SectionProgressBar extends StatelessWidget {
  const SectionProgressBar(
      {super.key,
      required this.lightThemeBarEnabled,
      this.progressBarDisabled});

  final bool lightThemeBarEnabled;
  final bool? progressBarDisabled;

  Future<bool?> _showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppPalette.white,
          title: Text(
            'Are you sure?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppPalette.blackColor,
            ),
          ),
          content: const Text(
            'Are you sure you want to leave this page?',
            style: TextStyle(color: AppPalette.blackColor),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Nevermind'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Leave'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 36, 18, 18),
      child: Row(
        children: [
          GestureDetector(
              onTap: () async {
                final bool shouldPop = await _showBackDialog(context) ?? false;
                if (context.mounted && shouldPop) {
                  Navigator.pop(context);
                }
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
          progressBarDisabled == null
              ? Expanded(
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
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                      );
                    },
                  ),
                )
              : Spacer(),
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
