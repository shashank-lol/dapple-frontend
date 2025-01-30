import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LearningCard extends StatelessWidget {
  const LearningCard({super.key, this.isRecommended = true});

  final bool isRecommended;

  @override
  Widget build(BuildContext context) {
    const courseName = "Travel newbie";
    const level = 1;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          gradient: AppPalette.primaryGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  "assets/mask_bottom.svg",
                  width: deviceHeight / 1.5,
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      isRecommended
                          ? "RECOMMENDED FOR YOU"
                          : "CONTINUE LEARNING",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white.withValues(alpha: 0.75))),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Image.asset("assets/dapple-girl/point.png",
                          height: deviceHeight / 6),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(courseName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white, fontSize: 20)),
                          Text("Level $level".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color:
                                          Colors.white.withValues(alpha: 0.75),
                                      fontSize: 12)),
                          const SizedBox(height: 24),
                          // const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppPalette.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("learn now".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppPalette.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ],
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
