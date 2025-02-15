import 'package:dapple/core/utils/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/utils/sound.dart';
import '../../../../../core/widgets/custom_text_rubik.dart';

class SuccessOverlay extends StatelessWidget {
  const SuccessOverlay(
      {super.key,
      required this.showOverlay,
      required this.xp,
      this.description});

  final bool showOverlay;
  final int xp;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showOverlay ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        color: Color(0xBB1B125E),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(
              flex: 3,
            ),
            Image.asset(
              'assets/dapple-girl/jump.png', // Replace with your image
              width: 300,
            ).jumpingAnimation().callback(
                duration: 0.ms,
                callback: (_) => SoundManager.playSuccessEffect()),
            Spacer(
              flex: 1,
            ),
            description != null
                ? CustomTextRubik(
                    text: description!,
                    weight: FontWeight.w500,
                    size: 14,
                    color: AppPalette.white)
                : Container(),
            Spacer(
              flex: 1,
            ),
            CustomTextRubik(
                text: 'Excellent',
                weight: FontWeight.w800,
                size: 40,
                color: AppPalette.white),
            SizedBox(height: 10),
            CustomTextRubik(
                text: '+$xp XP',
                weight: FontWeight.w700,
                size: 24,
                color: AppPalette.secondaryColor),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
