import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPalette{
  static const bgColor = Color(0xFFF9F9F9);
  static const primaryColor = Color(0xFF6A5AE0);
  static const blackColor = Color(0xFF1A1A1A);
  static const primaryLightColor = Color(0xFFEFEEFC);
  static const white = Color(0xFFFFFFFF);
  static const transparent = Color(0x00000000);
  static const grey =Color(0xFFCCCCCC);
  static const secondaryColor = Color(0xFFF06100);

  //daily problem colors
  static const lightPinkColor = Color(0xFFFFE0E6);
  static const lightgreyColor = Color(0xFF333333);

  //section block colors
  static const section_title_color_on = Color(0xFF0D0B26);
  static const section_title_color_off = Color(0xFFABB7C2);
  static const section_subtitle_color_off = Color(0xFFABB7C2);
  static const icon_bgcolor_on = Color(0xFF6A5AE0);
  static const icon_bgcolor_off = Color(0xFFCFD6DC);

  //learning screen
  static const progressbarcolor =Color(0xFFB9B2F0);
  static const learningtextcolor = Color(0xFF191919);








  static BoxShadow primaryShadow = BoxShadow(
    color: Colors.grey.withValues(alpha: 0.2),
    spreadRadius: 1,
    blurRadius: 7,
    offset: Offset(0, 3),
  );

  static LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B7EE7), Color(0xFF6A5AE0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}