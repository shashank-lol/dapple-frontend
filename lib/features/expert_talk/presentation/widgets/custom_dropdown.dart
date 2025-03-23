import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {super.key,
      required this.hint,
      required this.items,
      required this.onChanged});

  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFC),
        border: Border.all(color: Color(0xFFF4F4F6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppPalette.blackColor),
          borderRadius: BorderRadius.circular(20),
          hint: Text(
            widget.hint,
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.4,
                color: Color(0xFFAAB6C3)),
          ),
          icon: SvgPicture.asset("assets/icons/dropdown.svg"),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged(value);
          },
          dropdownColor: Color(0xFFFAFAFC),
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppPalette.blackColor)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
