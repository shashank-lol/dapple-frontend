import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.primaryColor,
      required this.bgColor,
      this.child});

  final void Function() onTap;
  final String text;
  final Color primaryColor;
  final Color bgColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            padding: EdgeInsets.symmetric(vertical: 14)),
        child: child?? Text(
          text.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: primaryColor),
        ),
      ),
    );
  }
}
