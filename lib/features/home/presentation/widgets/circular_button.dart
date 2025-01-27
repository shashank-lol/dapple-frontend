import 'package:flutter/material.dart';
import '../../../../core/theme/app_palette.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({super.key, required this.icon, required this.action});

  final IconData icon;
  final GestureTapCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,5,15,5),
        child: Container(
          width: 40, // Diameter of the button
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            shape: BoxShape.circle, // Makes it circular
            border: Border.all(
              color: AppPalette.grey, // Border color
              width: 1, // Border width
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppPalette.primaryColor, // Icon color
              size: 20, // Icon size
            ),
          ),
        ),
      ),
    );
  }
}
