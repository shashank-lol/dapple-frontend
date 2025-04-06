import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({super.key, required this.iconUrl, required this.contact});

  final String iconUrl;
  final String contact;

  String formatStringWithAt(String input) {
    if (!input.contains('@')) {
      return input;
    }
    List<String> parts = input.split('@');
    if (parts.length >= 2) {
      return '${parts[0]}@\n${parts[1]}';
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconUrl,
          height: 30,
          colorFilter: ColorFilter.mode(AppPalette.primaryColor,
              BlendMode.srcIn), // You can adjust the size
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          formatStringWithAt(contact),
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.rubik(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppPalette.blackColor,
              letterSpacing: 0),
        )
      ],
    );
  }
}
