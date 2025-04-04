import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/indicators/rating_indicator.dart';

class ExpertTile extends StatelessWidget {
  const ExpertTile({super.key, required this.name, required this.rating, required this.experience});

  final String name;
  final String rating;
  final int experience;

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
                      image: AssetImage("assets/dapple-girl/hi.png"),
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
                      Text(
                        "$experience+ Yrs Experience",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Color(0x33384B66),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.4),
                      )
                    ],
                  ),
                ),
                Spacer(),
                RatingIndicator(rating: rating,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
