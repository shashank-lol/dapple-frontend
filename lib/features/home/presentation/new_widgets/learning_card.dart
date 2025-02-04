import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/cubits/app_user/app_user_cubit.dart';

class LearningCard extends StatelessWidget {
  const LearningCard({super.key, this.isRecommended = true});

  final bool isRecommended;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppPalette.lightPinkColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: 100,
                right: 50,
                child: SvgPicture.asset(
                  "assets/learningcard_background.svg",
                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Text("YOUR DAILY GOAL",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppPalette.lightgreyColor,
                              fontSize: 14,
                            )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Image.asset("assets/icons/goal.png", height: 80),
                        const SizedBox(width: 8),
                        BlocBuilder<AppUserCubit, AppUserState>(
                            builder: (context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Improving Confidence",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppPalette.lightgreyColor,
                                        fontSize: 18,
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
                                            color: AppPalette.lightgreyColor,
                                            fontSize: 12,
                                          )),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
