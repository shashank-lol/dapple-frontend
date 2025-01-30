import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFBCB6F1), Color(0xFFFFFFFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.7],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppPalette.blackColor.withValues(alpha: 0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/courses_thumbnail/chat.png"),
          const SizedBox(height: 8),
          Text(name,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(height: 1.2)),
          const SizedBox(
            height: 2,
          ),
          Text(
            "5 Levels",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Image.asset("assets/xp.png", height: 16),
              const SizedBox(width: 4),
              Text(
                "1000 XP",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppPalette.secondaryColor,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )
        ],
      ),
    );
  }
}
