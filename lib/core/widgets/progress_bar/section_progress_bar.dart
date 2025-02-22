import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/app_palette.dart';
import '../indicators/lives_indicator.dart';

class SectionProgressBar extends StatelessWidget {
  const SectionProgressBar(
      {super.key,
      required this.backButtonColor,
      required this.progressColor,
      required this.bgColor,
      required this.progressBar,
      required this.livesIndicator});

  final Color backButtonColor;
  final Color progressColor;
  final Color bgColor;
  final bool progressBar;
  final bool livesIndicator;

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
                colorFilter: ColorFilter.mode(backButtonColor, BlendMode.srcIn),
              )),
          SizedBox(
            width: 10,
          ),
          progressBar
              ? Expanded(
                  child: BlocBuilder<QuestionsCubit, QuestionsState>(
                    builder: (context, state) {
                      final progress = (state as QuestionsLoaded).currentIndex /
                          (state).questions.length;
                      return LinearProgressIndicator(
                        value: progress,
                        // 50% progress
                        backgroundColor: bgColor,
                        // Background color
                        color: progressColor,
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
          livesIndicator
              ? LivesIndicator(
                  textColor: backButtonColor,
                )
              : Container(),
        ],
      ),
    );
  }
}
