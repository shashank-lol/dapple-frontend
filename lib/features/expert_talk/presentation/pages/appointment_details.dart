import 'package:dapple/core/widgets/buttons/custom_button.dart';
import 'package:dapple/features/expert_talk/domain/entities/appointment.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/expert_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_palette.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({super.key, required this.appointment});

  final Appointment appointment;

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
        title: Row(
          children: [
            Text(
              "Appointment Details",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                height: 1.6,
                color: AppPalette.blackColor,
              ),
            ),
            Spacer(),
            SvgPicture.asset("assets/icons/menu.svg"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpertTile(
              rating: widget.appointment.expertRating,
              name: widget.appointment.expertName,
              description: widget.appointment.expertDescription,
              imageUrl: widget.appointment.imageUrl,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Schedule",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppPalette.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppPalette.white,
                      border: Border.all(color: Color(0xFFF3F2FD), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            widget.appointment.date,
                            style: GoogleFonts.rubik(
                                color: AppPalette.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.4),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "DATE",
                            style: GoogleFonts.rubik(
                                color: Color(0xFF7D8A95),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppPalette.white,
                      border: Border.all(color: Color(0xFFF3F2FD), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "${widget.appointment.startTime}-${widget.appointment.endTime}",
                            style: GoogleFonts.rubik(
                                color: AppPalette.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.4),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "TIME",
                            style: GoogleFonts.rubik(
                                color: Color(0xFF7D8A95),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Message",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppPalette.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppPalette.white,
                border: Border.all(color: Color(0xFFF3F2FD), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLines: 4,
                controller: controller,
                style: GoogleFonts.rubik(
                    fontSize: 14,
                    color: AppPalette.blackColor,
                    fontWeight: FontWeight.w400,
                    height: 1.4),
                decoration: InputDecoration(
                  hintText: "Write a message for the expert",
                  hintStyle: GoogleFonts.rubik(
                      color: Color(0xFFB2BCC9),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4),
                ),
              ),
            ),
            Spacer(),
            CustomButton(onTap: () {}, buttonText: "show in calendar")
          ],
        ),
      ),
    );
  }
}
