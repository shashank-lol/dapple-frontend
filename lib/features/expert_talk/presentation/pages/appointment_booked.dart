import 'package:dapple/core/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_palette.dart';

class AppointmentBookedPage extends StatefulWidget {
  const AppointmentBookedPage({super.key, required this.calendarLink});
  final String calendarLink;

  @override
  State<AppointmentBookedPage> createState() => _AppointmentBookedPageState();
}

class _AppointmentBookedPageState extends State<AppointmentBookedPage> {

  Future<void> openGoogleCalendar(String calendarLink) async {
    final Uri url = Uri.parse(calendarLink);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $calendarLink';
    }
  }

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
              child: CustomButton(onTap: () async {
                await openGoogleCalendar(widget.calendarLink);
              }, buttonText: "Go to Calendar"),
            )
          ],
        ),
      ),
    );
  }
}
