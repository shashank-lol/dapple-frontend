import 'package:dapple/core/widgets/primary_button.dart';
import 'package:dapple/core/widgets/section_progress_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_palette.dart';

class QuestionTemplateScreen extends StatelessWidget {
  const QuestionTemplateScreen(
      {super.key,
      required this.widgetTop,
      required this.widgetBottom,
      required this.onTap,
      required this.resizeToAvoidBottomInset});

  final Widget widgetTop;
  final Widget widgetBottom;
  final void Function() onTap;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        children: [
          ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Color(0x66FFFFFF), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ).createShader(bounds);
              },
              blendMode: BlendMode.lighten, // Darkening effect
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image_bg.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          AppPalette.primaryColor, BlendMode.color)),
                ),
              )),
          Column(
            children: [
              SectionProgressBar(),
              Spacer(),
              widgetTop,
              Spacer(),
              Container(
                // Adjust width as needed
                height: MediaQuery.of(context).size.height *
                    3 /
                    5, // Adjust height as needed
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  minimum: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widgetBottom,
                      Spacer(),
                      const SizedBox(
                        height: 8,
                      ),
                      PrimaryButton(
                          onTap: onTap,
                          text: "Continue",
                          primaryColor: AppPalette.white,
                          bgColor: AppPalette.primaryColor),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
