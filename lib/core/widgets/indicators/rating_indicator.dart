import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingIndicator extends StatelessWidget {
  const RatingIndicator({super.key, required this.rating});
  final String rating ;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
          color: AppPalette.secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/starwhite.svg",height: 15,width: 15,),
              SizedBox(width: 5,),
              Text(
                rating,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    color: AppPalette.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4),
              )

            ],
          ),
        ),
      ),
    );
  }
}
