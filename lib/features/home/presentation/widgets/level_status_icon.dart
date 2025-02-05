import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../data/levelstatus.dart';

class LevelStatusIcon extends StatelessWidget {
  const LevelStatusIcon(
      {super.key, required this.status, required this.levelnumber});

  final LevelStatus status;
  final int levelnumber;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle, // Makes it round
            borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: status == LevelStatus.locked
            ? Text(
                '$levelnumber',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
              )
            : status == LevelStatus.current
                ? SvgPicture.asset(
                    'assets/buttons/current_level.svg', // Path to your SVG
                    width: 20,
                    height: 20, // Optional: Change color
                  )
                : SvgPicture.asset(
                    'assets/icons/tick.svg', // Path to your SVG
                    width: 30,
                    height: 30, // Optional: Change color
                  ));
  }
}
