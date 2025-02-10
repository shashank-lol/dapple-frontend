import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';


class LearningCard extends StatelessWidget {
  const LearningCard({super.key});

  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          color: AppPalette.lightPinkColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Text("YOUR DAILY GOAL",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppPalette.lightGreyColor,
                              fontSize: 14,
                            )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.asset("assets/icons/goal.png",
                            ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Improving Confidence",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppPalette.lightGreyColor,
                                      fontSize: 16,
                                    )),
                            SizedBox(
                              height: 4,
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                    softWrap: true,
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: AppPalette.lightGreyColor,
                                          fontSize: 12,
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
