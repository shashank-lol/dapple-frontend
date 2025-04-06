import 'package:dapple/features/expert_talk/presentation/bloc/book_appointment/book_appointment_cubit.dart';
import 'package:dapple/features/expert_talk/presentation/bloc/book_appointment/expert_schedule_cubit.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/date_picker.dart';
import 'package:dapple/features/expert_talk/presentation/widgets/timeslot_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routes/app_route_consts.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../domain/entities/expert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpertInfoScreen extends StatefulWidget {
  const ExpertInfoScreen({super.key, required this.expert});

  final Expert expert;

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
  void initState() {
    context.read<ExpertScheduleCubit>().loadSchedule(widget.expert.expertId);
    super.initState();
  }

  String? selectedTimeSlotId;

  void _onSlotSelected(String? timeSlotId) {
    setState(() {
      selectedTimeSlotId = timeSlotId; // Update parent state
    });
    if (timeSlotId != null) {
      print('Selected time slot ID in parent: $timeSlotId');
      // You can now use this ID to book the appointment or perform other actions
    } else {
      print('No time slot selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookAppointmentCubit, BookAppointmentState>(
      listener: (context, state) {
        if (state is AppointmentBooked) {
          GoRouter.of(context).pushNamed(
              AppRouteConsts.appointmentBooked,
              pathParameters: {
                "calendarLink": state.meeting.calendarLink
              });
        }
      },
      child: Scaffold(
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
        body: Stack(
          children: [
            Image.asset("assets/icons/doctor.png"),
            Column(
              children: [
                Spacer(),
                Container(
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
                          height: 500,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.expert.name,
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
                                      widget.expert.rating.toString(),
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
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                                  widget.expert.description,
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
                                            widget.expert.experience,
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
                                            widget.expert.patientsTreated,
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
                                            widget.expert.xp.toString(),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppPalette.blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                DatePickerWidget(
                                  maxDate:
                                      DateTime.now().add(Duration(days: 15)),
                                  onDateSelected: _onDateSelected,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Schedules",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppPalette.blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          height: 1.4),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ScheduleWidget(
                                  date: _selectedDay,
                                  onSlotSelected: _onSlotSelected,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
                          builder: (context, state) {
                            return CustomButton(
                              onTap: () async {
                                debugPrint(selectedTimeSlotId);
                                // selectedTimeSlotId == null
                                //     ? null // Disable if no slot is selected
                                //     : () async {
                                //         // Here you can use selectedTimeSlotId to book the appointment
                                //         // For example, call your Cubit or use case
                                await context
                                    .read<BookAppointmentCubit>()
                                    .bookNewAppointment(selectedTimeSlotId!);
                                // };
                              },
                              buttonText: 'Book Now',
                              child: state is AppointmentLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
