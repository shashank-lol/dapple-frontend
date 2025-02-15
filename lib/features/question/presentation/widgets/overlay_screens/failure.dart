import 'package:dapple/core/utils/sound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/widgets/text/custom_text_rubik.dart';

class FailureOverlay extends StatefulWidget {
  const FailureOverlay(
      {super.key, required this.showOverlay, this.description});

  final bool showOverlay;
  final String? description;

  @override
  State<FailureOverlay> createState() => _FailureOverlayState();
}

class _FailureOverlayState extends State<FailureOverlay> {
  @override
  void initState() {
    SoundManager.playFailureSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.showOverlay ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        color: Color(0xBB1B125E),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset(
              'assets/dapple-girl/sad.png', // Replace with your image
              width: 300,
            ),
            Spacer(
              flex: 1,
            ),
            widget.description != null
                ? CustomTextRubik(
                    text: widget.description!,
                    weight: FontWeight.w500,
                    size: 14,
                    color: AppPalette.white)
                : Container(),
            Spacer(
              flex: 1,
            ),
            Text('WRONG \nANSWER',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppPalette.secondaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w800)),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
