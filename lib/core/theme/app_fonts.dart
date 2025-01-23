import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

class AppFonts{
  TextTheme textTheme = TextTheme(
    headlineMedium: GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppPalette.blackColor,
    ),
    bodySmall: GoogleFonts.inter(fontSize: 12, color: Colors.grey, height:1.6),
  );
}