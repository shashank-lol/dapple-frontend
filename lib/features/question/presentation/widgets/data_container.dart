import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/text/custom_text_rubik.dart';
import 'package:flutter/cupertino.dart';

class DataContainer extends StatelessWidget {
  const DataContainer({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppPalette.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextRubik(
                text: title,
                weight: FontWeight.w600,
                size: 12,
                color: AppPalette.primaryColor),
            SizedBox(
              height: 4,
            ),
            CustomTextRubik(
                text: subtitle,
                weight: FontWeight.w600,
                size: 24,
                color: AppPalette.primaryColor),
          ],
        ),
      ),
    );
  }
}
