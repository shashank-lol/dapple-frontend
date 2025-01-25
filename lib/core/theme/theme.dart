import 'package:dapple/core/theme/app_fonts.dart';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData().copyWith(
    scaffoldBackgroundColor: AppPalette.bgColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: Colors.grey.shade50,
        elevation: 2,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        color: AppPalette.blackColor,
        fontWeight: FontWeight.w500,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPalette.primaryLightColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.primaryLightColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle:GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppPalette.blackColor.withValues(alpha: 0.3),
      ),
    ),
    textTheme: AppFonts().textTheme,
  );
}
