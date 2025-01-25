import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {

      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Continue With  ".toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium
            ),
            SvgPicture.asset("assets/G__logo.svg", height: 20),
          ],
        ),
      ),
    );
  }
}
