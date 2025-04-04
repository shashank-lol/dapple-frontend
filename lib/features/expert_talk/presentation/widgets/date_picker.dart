import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerLogic {
  DateTime selectedDate = DateTime.now();
  DateTime startOfWeek = DateTime.now();
  int week=0;
  final DateTime maxDate;

  DatePickerLogic({required this.maxDate}) {
    startOfWeek = _getStartOfWeek(selectedDate);
  }

  DateTime _getStartOfWeek(DateTime date) {
    final int dayOfWeek = date.weekday;
    final DateTime startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));
    return startOfWeek.weekday == DateTime.monday
        ? startOfWeek
        : startOfWeek.subtract(Duration(days: 7));
  }

  void selectDate(DateTime date) {
    if (!date.isBefore(DateTime.now().subtract(Duration(days: 1))) && !date.isAfter(maxDate)) {
      selectedDate = date;
    }
  }

  void nextWeek() {
    if (startOfWeek.add(Duration(days: 7)).isBefore(maxDate)) {
      startOfWeek = startOfWeek.add(Duration(days: 7));
      week++;
    }
  }

  void previousWeek() {
    if (startOfWeek.isAfter(_getStartOfWeek(DateTime.now()))) {
      startOfWeek = startOfWeek.subtract(Duration(days: 7));
      week--;
    }
  }

  bool isCurrentWeek() {
    return startOfWeek.isAtSameMomentAs(_getStartOfWeek(DateTime.now()));
  }

  bool isMaxWeek() {
    return startOfWeek.add(Duration(days: 7)).isAfter(maxDate);
  }
}

class DatePickerWidget extends StatefulWidget {
  final DateTime maxDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerWidget({super.key, required this.maxDate, required this.onDateSelected});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DatePickerLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = DatePickerLogic(maxDate: widget.maxDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (_logic.week!=0) // Load left button only if not current week
              GestureDetector(
                onTap: () {
                  setState(() {
                    _logic.previousWeek();
                  });
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppPalette.primaryColor,
                ),
              ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(7, (index) {
                  final DateTime date = _logic.startOfWeek.add(Duration(days: index));
                  final bool isSelected = date.isAtSameMomentAs(_logic.selectedDate);
                  final bool isSelectable = !date.isBefore(DateTime.now().subtract(Duration(days: 1))) && !date.isAfter(widget.maxDate);
                  final String dayName = DateFormat('EEEE').format(date);
                  final String dayNumber = DateFormat('d').format(date);

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (isSelectable) {
                          setState(() {
                            _logic.selectDate(date);
                            widget.onDateSelected(date);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFFECEAFB) : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Column(
                            children: [
                              Text(
                                dayNumber,
                                style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  color: isSelected
                                      ? AppPalette.primaryColor
                                      : isSelectable
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              Text(
                                dayName.substring(0, 2),
                                style: GoogleFonts.rubik(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: isSelected
                                      ? AppPalette.primaryColor
                                      : isSelectable
                                      ? Color(0xFF94A3B8)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            if (!_logic.isMaxWeek()) // Load right button only if not max week
              GestureDetector(
                onTap: () {
                  setState(() {
                    _logic.nextWeek();
                  });
                },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppPalette.primaryColor,
                ),
              ),
          ],
        ),
      ],
    );
  }
}