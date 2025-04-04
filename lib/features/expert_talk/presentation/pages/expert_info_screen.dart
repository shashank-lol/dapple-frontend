import 'package:dapple/core/utils/show_snackbar.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/date_picker.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/timeslot_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../widgets/custom_dropdown.dart';

class ExpertInfoScreen extends StatefulWidget {
  const ExpertInfoScreen({super.key});

  @override
  State<ExpertInfoScreen> createState() => _ExpertInfoScreenState();
}

class _ExpertInfoScreenState extends State<ExpertInfoScreen> {
  DateTime _selectedDay = DateTime.now();

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDay = selectedDate;
    });
    if (kDebugMode) {
      print(_selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
        iconTheme: IconThemeData(
          color: AppPalette.white,
        ),
        title: Text(
          "Expert Info",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppPalette.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.6),
        ),
      ),
      body: Column(
        children: [
          Image.asset("assets/icons/doctor.png"),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppPalette.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 80, // Adjust width as needed
                        height: 4, // Adjust height as needed
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Light grey color
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "David H. Brown",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppPalette.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4),
                        ),
                        Spacer(),
                        Text(
                          "4.8",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppPalette.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: SvgPicture.asset(
                            "assets/icons/star.svg",
                            height: 20,
                            width: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Psychologists | Apollo hospital",
                      style: GoogleFonts.rubik(
                          color: Color(0xFF7D8A95),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.6),
                    ),
                    Divider(
                      thickness: 2,
                      height: 50,
                      color: Color(0xFFF4F4F6),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "15 Years",
                                style: GoogleFonts.rubik(
                                    color: AppPalette.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Experience".toUpperCase(),
                                style: GoogleFonts.rubik(
                                    color: Color(0xFF7D8A95),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "50+",
                                style: GoogleFonts.rubik(
                                    color: AppPalette.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Treated".toUpperCase(),
                                style: GoogleFonts.rubik(
                                    color: Color(0xFF7D8A95),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "1600",
                                style: GoogleFonts.rubik(
                                    color: AppPalette.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "XP Req".toUpperCase(),
                                style: GoogleFonts.rubik(
                                    color: Color(0xFF7D8A95),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Select Date",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppPalette.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // WeeklyDatePicker(
                    //   backgroundColor: AppPalette.white,
                    //   selectedDay: _selectedDay,
                    //   changeDay: (value) => setState(() {
                    //     _selectedDay = value;
                    //   }),
                    //   enableWeeknumberText: false,
                    //   weekdays: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
                    //   selectedDigitBackgroundColor: Color(0xFFECEAFB),
                    //   selectedDigitColor: AppPalette.primaryColor,
                    //
                    // ),
                    DatePickerWidget(
                      maxDate: DateTime.now().add(Duration(days: 15)),
                      onDateSelected: _onDateSelected,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Schedules",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppPalette.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TimeslotSelector(),
                    Spacer(),
                    CustomButton(
                      onTap: () {
                        showSnackBar(
                            context, "Appointment booked successfully");
                      },
                      buttonText: 'Book Now',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
