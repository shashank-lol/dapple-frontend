import 'package:dapple/core/theme/app_fonts.dart';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:dapple/features/home/presentation/widgets/level_status_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({super.key, required this.level, required this.heading, required this.status});

  final int level;
  final String heading;
  final LevelStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppPalette.primaryColor,
            AppPalette.primaryColor,
          ]),
          color: AppPalette.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LevelStatusIcon(
                status: status,
              ),
              SizedBox(
                height: 10,
              ),
              Text('level $level',style: TextStyle(
                color: AppPalette.white
              ),),
              Text('$heading',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.white
              )),

            ],
          ),
        ),
      ),
    );
  }
}
