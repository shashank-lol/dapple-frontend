import 'package:dapple/core/widgets/primary_button.dart';
import 'package:dapple/features/home/domain/entities/section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_route_consts.dart';
import '../../../../core/theme/app_palette.dart';

class StartPage extends StatelessWidget {
  const StartPage(this.section, {super.key});

  final Section section;

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
              colorFilter:
                  ColorFilter.mode(AppPalette.primaryColor, BlendMode.color)),
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
                "assets/dapple-girl/jump.png",
                height: deviceHeight / 3,
              )),
              const SizedBox(height: 60),
              Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "This section contains 4 lessons and 4 MCQ type questions. Earn at least 50 XP to clear this section.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppPalette.white.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              PrimaryButton(
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                        AppRouteConsts.learn,);
                  },
                  text: "Start +${section.sectionXp} XP",
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
