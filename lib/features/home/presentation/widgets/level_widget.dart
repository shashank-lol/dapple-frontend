import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:dapple/features/home/presentation/widgets/level_status_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget(
      {super.key,
      required this.currentlevel,
      required this.heading,
      required this.status, required this.description, required this.level});

  final int currentlevel;
  final String heading;
  final String description;
  final LevelStatus status;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: status == LevelStatus.locked?0.6:1,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppPalette.primaryGradient,
                color: AppPalette.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LevelStatusIcon(
                      status: status,
                      levelnumber: level,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(heading,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white, fontSize: 20)),
                    Text(
                        description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Color(0xFFB3B3B3), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/dapple-girl/point.png',
                height: 150,
              )),
        ],
      ),
    );
  }
}
