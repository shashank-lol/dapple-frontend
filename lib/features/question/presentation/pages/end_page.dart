import 'package:dapple/core/widgets/text/custom_text_rubik.dart';
import 'package:dapple/features/question/presentation/widgets/data_container.dart';
import 'package:dapple/features/question/presentation/widgets/section_progress_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

class EndPage extends StatelessWidget {
  const EndPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0,
        title: SectionProgressBar(
          lightThemeBarEnabled: true,
          progressBarDisabled: true,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppPalette.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image_bg.png"),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(AppPalette.primaryColor, BlendMode.color)),
        ),
        child: SafeArea(
          minimum: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                "assets/dapple-girl/success.png",
                height: deviceHeight *2/5,
              )),
              Text('SECTION\nCOMPLETED',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    height: 0,
                      color: AppPalette.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700)),
              const Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Expanded(
                      child:
                          DataContainer(title: "XP GAINED", subtitle: "400")),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataContainer(
                          title: "TIME TAKEN", subtitle: "10:02")),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DataContainer(title: "LESSONS", subtitle: "4")),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              PrimaryButton(
                  onTap: () {},
                  text: "START NEXT SECTION",
                  primaryColor: AppPalette.primaryColor,
                  bgColor: Colors.white),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
