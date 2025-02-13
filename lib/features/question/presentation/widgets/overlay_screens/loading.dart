import 'package:flutter/material.dart';
import '../../../../../core/theme/app_palette.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key, required this.showOverlay});

  final bool showOverlay;

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
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFFFD7BD),
                color: AppPalette.secondaryColor,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              textAlign: TextAlign.center,
              'Evaluating your answer',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppPalette.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
