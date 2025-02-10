import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_palette.dart';
import 'lives_indicator.dart';

class SectionProgressBar extends StatelessWidget {
  const SectionProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 36, 18, 18),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset('assets/section/cross.svg')),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: 0.5,
              // 50% progress
              backgroundColor: AppPalette.progressbarcolor,
              // Background color
              color: Colors.white,
              // Progress color
              minHeight: 8,
              // Thickness of the bar
              borderRadius: BorderRadius.circular(4), // Rounded corners
            ),
          ),
          SizedBox(
            width: 10,
          ),
          LivesIndicator(),
        ],
      ),
    );
  }
}
