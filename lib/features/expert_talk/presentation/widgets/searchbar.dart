import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(15),
          boxShadow: [AppPalette.primaryShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/search.svg',
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                cursorColor: AppPalette.blackColor,
                style: GoogleFonts.rubik(
                  fontSize: 12,
                  color: AppPalette.blackColor,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Search for experts',
                  hintStyle: GoogleFonts.rubik(
                    fontSize: 12,
                    color: Color(0x64646F33),
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero, // Ensures no extra padding
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/mic.svg',
              width: 25,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
