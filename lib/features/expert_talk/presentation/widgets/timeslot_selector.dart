import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeslotSelector extends StatefulWidget {
  const TimeslotSelector({super.key});

  @override
  State<TimeslotSelector> createState() => _TimeslotSelectorState();
}

class _TimeslotSelectorState extends State<TimeslotSelector> {
  final List<Map<String, dynamic>> timeSlots = [
    {'time': '10:30am - 11:30am', 'available': true},
    {'time': '11:30am - 12:30pm', 'available': true},
    {'time': '12:30pm - 1:30pm', 'available': false},
    {'time': '2:30pm - 3:30pm', 'available': true},
  ];

  String? selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: timeSlots.map((slot) {
        bool isAvailable = slot['available'];
        String time = slot['time'];
        bool isSelected = selectedSlot == time;

        return GestureDetector(
          onTap: isAvailable
              ? () {
            setState(() {
              // Toggle selection
              if (isSelected) {
                selectedSlot = null; // Deselect if already selected
              } else {
                selectedSlot = time;
              }
            });
          }
              : null, // Do nothing if slot is unavailable
          child: Opacity(
            opacity: isAvailable ? 1.0 : 0.3, // Only opacity changes if unavailable
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: AppPalette.white, // No color change
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? AppPalette.primaryColor : Color(0xFFF0F4FC),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(time,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.3,
                      color: AppPalette.blackColor)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
