import 'package:dapple/core/widgets/section_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routes/app_route_consts.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/primary_button.dart';

class Learningscreen extends StatelessWidget {
  const Learningscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Color(0x99000000), Colors.transparent],
                    // Dark to Transparent
                    begin: Alignment.topCenter,
                    // Dark on the left side
                    end: Alignment.center, // Transparent on the right side
                  ).createShader(bounds);
                },
                blendMode: BlendMode.darken, // Darkening effect
                child: Image.asset(
                  'assets/section/learning_bg.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SectionProgressBar(),
              Spacer(),
              Container(
                // Adjust width as needed
                height: MediaQuery.of(context).size.height *
                    3 /
                    5, // Adjust height as needed
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ), // Border radius 20
                  image: DecorationImage(
                    image: AssetImage("assets/section/image_bg_white.png"),
                    // Your background image
                    fit: BoxFit.cover, // Covers the container
                  ),
                ),
                child: SafeArea(
                  minimum: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPalette.learningtextcolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 5,
                        child: SingleChildScrollView(
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry .Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when anIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged It was popular in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently versions of Lorem Ipsum.",
                            style: GoogleFonts.rubik(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppPalette.learningtextcolor),
                          ),
                        ),
                      ),
                      Spacer(),
                      const SizedBox(
                        height: 8,
                      ),
                      PrimaryButton(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(AppRouteConsts.subjectiveQuestionScreen);
                          },
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
