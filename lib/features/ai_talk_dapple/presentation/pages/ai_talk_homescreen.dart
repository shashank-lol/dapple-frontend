import 'package:dapple/core/widgets/buttons/custom_button.dart';
import 'package:dapple/features/ai_talk_dapple/presentation/widgets/role_selector.dart';
import 'package:dapple/features/ai_talk_dapple/presentation/widgets/suggestions_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/indicators/xp_indicator_orange.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';

class AiTalkHomeScreen extends StatefulWidget {
  const AiTalkHomeScreen({super.key});

  @override
  State<AiTalkHomeScreen> createState() => _AiTalkHomeScreenState();
}

class _AiTalkHomeScreenState extends State<AiTalkHomeScreen> {
  String selectedRole = "";

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppPalette.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppPalette.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        width: 80,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F2F6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Select Role",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppPalette.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoleSelector(),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                        CustomButton(onTap: () {}, buttonText: "Request Call"),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
        title: Row(
          children: [
            SizedBox(
              width: 3,
            ),
            CustomTextRubik(
                text: "Talk with Dapple",
                weight: FontWeight.w600,
                size: 20,
                color: AppPalette.blackColor),
            Spacer(),
            XpIndicatorOrange(100)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Image.asset(
                  "assets/dapple-girl/dapple_instruct.png",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Talk with Dapple by selecting any role or topic of your choice! Talk upto 10 minutes",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5,
                    letterSpacing: 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Suggestions",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppPalette.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SuggestionsTile(
                      imageUrl: "assets/dapple-girl/karan.jpeg",
                      title: "Prof. Dapple",
                      description:
                          "Talk with Dapple about an assignment which you are not able to understand"),
                  SuggestionsTile(
                      imageUrl: "assets/dapple-girl/karan.jpeg",
                      title: "Prof. Dapple",
                      description:
                          "Talk with Dapple about an assignment which you are not able to understand"),
                  SuggestionsTile(
                      imageUrl: "assets/dapple-girl/karan.jpeg",
                      title: "Prof. Dapple",
                      description:
                          "Talk with Dapple about an assignment which you are not able to understand"),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(
                  onTap: () => _showBottomSheet(context),
                  buttonText: "Request Call"),
            )
          ],
        ),
      ),
    );
  }
}
