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
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      color: AppPalette.blackColor,
      fontWeight: FontWeight.w600,
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
  );
}
