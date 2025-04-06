import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/time_slot.dart';
import '../bloc/book_appointment/expert_schedule_cubit.dart';

class ScheduleWidget extends StatefulWidget {
  final DateTime date;
  final Function(String?)? onSlotSelected; // Callback to notify parent of selection changes

  const ScheduleWidget({
    super.key,
    required this.date,
    this.onSlotSelected, // Optional callback
  });

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  String? selectedSlot;
  late List<TimeSlot> timeSlots;

  @override
  void initState() {
    super.initState();
    timeSlots = []; // Initialize as empty
  }

  List<TimeSlot> getSchedule() {
    return context.read<ExpertScheduleCubit>().getScheduleByDate(widget.date);
  }

  bool isAvailable(TimeSlot slot) {
    if (!slot.isAvailable) {
      debugPrint("Slot - ${slot.timeSlotId} is not available");
    }
    return slot.isAvailable; // Assuming TimeSlot has an isAvailable property
  }

  bool isSelected(TimeSlot slot) {
    return selectedSlot == slot.timeSlotId; // Assuming timeSlotId is unique
  }

  String getTimeDisplay(TimeSlot slot) {
    return '${slot.startTime.toLocal().hour}:${slot.startTime.toLocal().minute.toString().padLeft(2, '0')} - ${slot.endTime.toLocal().hour}:${slot.endTime.toLocal().minute.toString().padLeft(2, '0')}';
  }

  @optionalTypeArgs
  void _onSlotTapped(TimeSlot slot) {
    setState(() {
      if (isSelected(slot)) {
        selectedSlot = null; // Deselect
      } else if (isAvailable(slot)) {
        selectedSlot = slot.timeSlotId; // Select
      }
    });

    // Notify parent of the selection change
    if (widget.onSlotSelected != null) {
      widget.onSlotSelected!(selectedSlot); // Pass null if deselecting
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpertScheduleCubit, ExpertScheduleState>(
      builder: (context, state) {
        if (state is ExpertScheduleLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExpertScheduleLoaded) {
          timeSlots = getSchedule();
          print(timeSlots.toString());
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: timeSlots.isEmpty
                ? [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Color(0xFFF0F4FC),
                    width: 1,
                  ),
                ),
                child: Text(
                  "No slots available",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
              ),
            ]
                : timeSlots.map((slot) {
              final time = getTimeDisplay(slot);
              return GestureDetector(
                onTap: () => _onSlotTapped(slot), // Use the new method
                child: Opacity(
                  opacity: isAvailable(slot) ? 1.0 : 0.1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected(slot) ? AppPalette.primaryColor : Color(0xFFF0F4FC),
                        width: isSelected(slot) ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      time,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.3,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        } else if (state is ExpertScheduleError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          // Default case (e.g., ExpertScheduleInitial)
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}