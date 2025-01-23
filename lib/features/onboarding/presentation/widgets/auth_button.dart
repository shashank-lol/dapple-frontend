import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.buttonText, required this.isPrimary, required this.onTap});

  final String buttonText;
  final bool isPrimary;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        onTap();
        debugPrint("Called");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary? AppPalette.primaryColor : Colors.white,
        minimumSize: Size(140, 48),
        // border: Border.all(
        //   color: AppPalette.primaryColor,
        //   width: 2
        // )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.rubik(
              color: isPrimary? Colors.white : AppPalette.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),
          ),
        ),
      ),
    );
  }
}
