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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        shadowColor: Colors.grey.shade50,
        elevation: 2
      )
    ),
    textTheme: AppFonts().textTheme
  );
}
