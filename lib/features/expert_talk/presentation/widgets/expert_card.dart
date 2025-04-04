import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/indicators/rating_indicator.dart';
import 'package:dapple/core/widgets/indicators/xp_indicator_orange.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_route_consts.dart';

class ExpertCard extends StatelessWidget {
  const ExpertCard(
      {super.key,
      required this.name,
      required this.description,
      required this.rating,
      required this.xp,
      required this.imageUrl});

  final String name;
  final String description;
  final double rating;
  final int xp;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppPalette.white,
        border: Border.all(color: Color(0xFFF3F2FD), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage("assets/dapple-girl/hi.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppPalette.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.4),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          description,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Color(0x33384B66),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                RatingIndicator(rating),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Available on 25 Dec".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppPalette.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.4),
                ),
                Spacer(),
                Transform.scale(scale: 0.8, child: XpIndicatorOrange(xp))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomButtonExpert(
              onTap: () {
                GoRouter.of(context).pushNamed(AppRouteConsts.expertInfoScreen);
              },
              bgColor: Color(0xFFD4D0F6),
              titleColor: AppPalette.primaryColor,
              title: 'Book Appointment',
            ),
          ],
        ),
      ),
    );
  }
}
