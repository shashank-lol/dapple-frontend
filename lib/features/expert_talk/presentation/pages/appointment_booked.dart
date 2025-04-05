import 'package:dapple/core/widgets/buttons/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_palette.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image_bg.png"),
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(AppPalette.white, BlendMode.color)),
        ),
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset(
              "assets/buttons/success2.svg",
              height: 250,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(onTap: () {}, buttonText: "Go to Calendar"),
            )
          ],
        ),
      ),
    );
  }
}
