import 'package:dapple/core/assets/professionals.dart';
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
            XpIndicatorOrange(1469)
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
                      AppointmentCard(
                          name: 'Dr. Aditi Sharma',
                          rating: '4.8',
                          date: '1 Jan',
                          time: '10:30 AM',
                          imageUrl: Professionals.aditi),
                      AppointmentCard(
                          name: 'Dr. Raj Malhotra',
                          rating: '4.5',
                          date: '2 Jan',
                          time: '02:00 PM',
                          imageUrl: Professionals.raj),
                      AppointmentCard(
                          name: 'Dr. Meera Kapoor',
                          rating: '4.7',
                          date: '3 Jan',
                          time: '09:15 AM',
                          imageUrl: Professionals.meera),
                      AppointmentCard(
                          name: 'Dr. Karan Singh',
                          rating: '4.6',
                          date: '4 Jan',
                          time: '11:45 AM',
                          imageUrl: Professionals.karan),
                      AppointmentCard(
                          name: 'Dr. Neha Verma',
                          rating: '4.9',
                          date: '5 Jan',
                          time: '01:30 PM',
                          imageUrl: Professionals.neha),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ExpertCard(
                  name: 'Dr. Aditi Sharma',
                  rating: '4.8',
                  date: '12 Feb',
                  minXP: 500,
                  experience: 10,
                  imageUrl: Professionals.aditi),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ExpertCard(
                  name: 'Dr. Raj Malhotra',
                  rating: '4.5',
                  date: '23 Mar',
                  minXP: 700,
                  experience: 8,
                  imageUrl: Professionals.raj),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ExpertCard(
                  name: 'Dr. Meera Kapoor',
                  rating: '4.7',
                  date: '5 Jul',
                  minXP: 900,
                  experience: 12,
                  imageUrl: Professionals.meera),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ExpertCard(
                  name: 'Dr. Karan Singh',
                  rating: '4.6',
                  date: '19 Sep',
                  minXP: 1100,
                  experience: 9,
                  imageUrl: Professionals.karan),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ExpertCard(
                  name: 'Dr. Neha Verma',
                  rating: '4.9',
                  date: '30 Nov',
                  minXP: 1500,
                  experience: 15,
                  imageUrl: Professionals.neha),
            ),
            // for (int i = 0; i < 5; i++)
            //   Padding(
            //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            //     child: ExpertCard(name: 'Dr. Neha Verma', rating: '4.9', date: '30 Nov', minXP: 1500, experience: 15, imageUrl: "assets/dapple-girl/hi.png"),

            //   ),
          ],
        ),
      ),
    );
  }
}
