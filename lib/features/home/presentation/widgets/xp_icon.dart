import 'package:flutter/material.dart';

class XpIcon extends StatelessWidget {
  const XpIcon(this.xp,{super.key});

  final int xp;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        "assets/xp.png",
        height: 36,
      ),
      const SizedBox(width: 8),
      Text("$xp\nXP",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold, height: 1, fontSize: 12))
    ]);
  }
}
