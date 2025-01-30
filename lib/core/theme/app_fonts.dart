import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

class AppFonts {
  TextTheme textTheme = TextTheme(
    headlineMedium: GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppPalette.blackColor,
    ),
    bodySmall: GoogleFonts.inter(fontSize: 12, color: Colors.grey, height: 1.6),
    bodyMedium: GoogleFonts.rubik(
      fontSize: 16,
      color: AppPalette.blackColor,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppPalette.primaryColor,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.rubik(
      color: AppPalette.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    titleMedium: GoogleFonts.rubik(
      color: AppPalette.blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    titleSmall: GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppPalette.blackColor),
  );
}
