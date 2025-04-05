import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_palette.dart';

class RoleSelector extends StatefulWidget {
  const RoleSelector({super.key});

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  final List<String> roles = [
    "Doctor",
    "Techer",
    "Parent",
    "Student",
    "Add your own",
  ];

  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: roles.map((slot) {
        bool isAvailable = true;
        String time = slot;
        bool isSelected = selectedRole == time;

        return GestureDetector(
          onTap: isAvailable
              ? () {
                  setState(() {
                    // Toggle selection
                    if (isSelected) {
                      selectedRole = null; // Deselect if already selected
                    } else {
                      selectedRole = time;
                    }
                  });
                }
              : null, // Do nothing if slot is unavailable
          child: Opacity(
            opacity: isAvailable ? 1.0 : 0.3,
            // Only opacity changes if unavailable
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: AppPalette.white, // No color change
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      isSelected ? AppPalette.primaryColor : Color(0xFFF0F4FC),
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
