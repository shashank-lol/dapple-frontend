import 'package:dapple/features/test_section/presentation/bloc/test_questions/test_questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/progress_bar/section_progress_bar.dart';

class TestTemplateScreen extends StatelessWidget {
  const TestTemplateScreen(
      {super.key,
      required this.widgetTop,
      required this.widgetBottom,
      required this.onTap,
      required this.resizeToAvoidBottomInset,
      this.buttonWidget,
      required this.buttonText});

  final Widget widgetTop;
  final Widget widgetBottom;
  final void Function() onTap;
  final bool resizeToAvoidBottomInset;
  final Widget? buttonWidget;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        children: [
          ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Colors.transparent, Colors.transparent],
                ).createShader(bounds);
              },
              blendMode: BlendMode.lighten, // Darkening effect
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/section/bg_image_sec.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          AppPalette.secondaryColor.withValues(
                            alpha: 50,
                          ),
                          BlendMode.color)),
                ),
              )),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SectionProgressBar(
                    backButtonColor: AppPalette.white,
                    progressColor: AppPalette.white,
                    bgColor: AppPalette.secondaryColorLight,
                    progressBar: true,
                    livesIndicator: false,
                    child: BlocBuilder<TestQuestionsCubit, TestQuestionsState>(
                      builder: (context, state) {
                        final progress =
                            (state as TestQuestionsLoaded).currentIndex /
                                (state).questions.length;
                        return LinearProgressIndicator(
                          value: progress,
                          // 50% progress
                          backgroundColor: AppPalette.secondaryColorLight,
                          // Background color
                          color: AppPalette.white,
                          // Progress color
                          minHeight: 8,
                          // Thickness of the bar
                          borderRadius:
                              BorderRadius.circular(4), // Rounded corners
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  widgetTop,
                  Spacer(),
                  Container(
                    // Adjust width as needed
                    height: MediaQuery.of(context).size.height *
                        2 /
                        3, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: widgetBottom),
                          PrimaryButton(
                            onTap: onTap,
                            text: buttonText,
                            primaryColor: AppPalette.white,
                            bgColor: AppPalette.secondaryColor,
                            child: buttonWidget,
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
