import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonExpert extends StatelessWidget {
  const CustomButtonExpert(
      {super.key,
      required this.onTap,
      required this.bgColor,
      required this.titleColor, required this.title});

  final GestureTapCallback onTap;
  final Color bgColor;
  final Color titleColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: titleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4),
          ),
        ),
      ),
    );
  }
}
