import 'package:flutter/material.dart';

class CustomTextRubik extends StatelessWidget {
  const CustomTextRubik(
      {super.key,
      required this.text,
      required this.weight,
      required this.size,
      required this.color});

  final String text;
  final FontWeight weight;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          !.copyWith(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
