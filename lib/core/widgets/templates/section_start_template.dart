import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';
import '../buttons/primary_button.dart';

class SectionStartTemplate extends StatelessWidget {
  const SectionStartTemplate(
      {super.key,
      required this.title,
      required this.description,
      required this.sectionXp,
      required this.onTap,
      required this.bgColor,
      required this.imagePath,});

  final String title;
  final Color bgColor;
  final String description;
  final int sectionXp;
  final void Function() onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image_bg.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(bgColor, BlendMode.color)),
        ),
        child: SafeArea(
          minimum: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceHeight / 7,
              ),
              Center(
                  child: Image.asset(
                imagePath,
                height: deviceHeight / 3,
              )),
              const SizedBox(height: 60),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppPalette.white.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              PrimaryButton(
                  onTap: onTap,
                  text: "Start +$sectionXp XP",
                  primaryColor: bgColor,
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
