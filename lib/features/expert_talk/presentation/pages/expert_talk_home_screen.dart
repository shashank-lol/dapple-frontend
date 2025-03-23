import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/indicators/xp_indicator_orange.dart';
import 'package:dapple/core/widgets/text/custom_text_rubik.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/appointment_card.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/expert_card.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExpertTalkHomeScreen extends StatelessWidget {
  const ExpertTalkHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
        title: Row(
          children: [
            SizedBox(
              width: 3,
            ),
            CustomTextRubik(
                text: "Talk with Expert",
                weight: FontWeight.w600,
                size: 20,
                color: AppPalette.blackColor),
            Spacer(),
            XpIndicatorOrange(25)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Searchbar(),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  "Upcoming Appointments",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppPalette.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.4),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: SizedBox(
                height: 120,
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AppointmentCard(),
                      AppointmentCard(),
                      AppointmentCard(),
                      AppointmentCard(),
                      AppointmentCard(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text(
                    "Find Experts",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppPalette.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                  Spacer(),
                  Text(
                    "See all",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppPalette.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.6),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: ExpertCard(),
              ),
          ],
        ),
      ),
    );
  }
}
