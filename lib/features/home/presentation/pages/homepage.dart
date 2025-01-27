import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:dapple/features/home/presentation/widgets/circular_button.dart';
import 'package:dapple/features/home/presentation/widgets/level_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  final String greeting = "Let's Play";
  final String name = "Be the first!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppPalette.bgColor,
        actions: [
          CircularButton(icon: CupertinoIcons.heart_fill, action: () {}),
          CircularButton(icon: Icons.person, action: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            Text(
              greeting,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(name,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.grey)),
            LevelWidget(level: 1, heading: 'Travel newbie', status: LevelStatus.completed,),
            LevelWidget(level: 2, heading: 'continuing', status: LevelStatus.current),
            LevelWidget(level: 3, heading: 'Locked', status: LevelStatus.locked),

          ],
        ),
      ),
    );
  }
}
