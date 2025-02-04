import 'package:dapple/features/home/presentation/new_widgets/lives_indicator.dart';
import 'package:dapple/features/home/presentation/new_widgets/xp_indicator.dart';
import 'package:dapple/features/home/presentation/new_widgets/learning_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_palette.dart';
import '../data/levelstatus.dart';
import '../widgets/level_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final int currentlevel = 2;
  final int currentsection=3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/avatar/1.svg",
              height: 40,
            ),
            const SizedBox(width: 8),
            Text("Hi Parth!",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppPalette.white)),
            const Spacer(),
            LivesIndicator(),
            const SizedBox(width: 15),
            XpIndicator()

            // const SizedBox(width: 8,)
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: LearningCard(),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppPalette.white, // Background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), // Round top-left corner
                  topRight: Radius.circular(20), // Round top-right corner
                ),
              ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: Text(
                  'Here is a personalized learning plan for you-',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 12),
                ),
              ),
            ),
            for (int i = 0; i < 5; i++)
              Container(
                color: AppPalette.white,
                child: LevelWidget(
                  heading: 'Travel newbie',
                  status: getLevelStatus(currentlevel, i),
                  currentlevel: currentlevel,
                  description:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting',
                  level: i + 1,
                  currentsection: currentsection,
                ),
              ),
          ],
        ),
      )),
    );
  }

  LevelStatus getLevelStatus(int currentLevel, int index) {
    index++;
    return index < currentLevel
        ? LevelStatus.completed
        : index == currentLevel
            ? LevelStatus.current
            : LevelStatus.locked;
  }
}
