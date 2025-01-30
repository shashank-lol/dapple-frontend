import 'package:dapple/features/home/presentation/widgets/features_icon.dart';
import 'package:dapple/features/home/presentation/widgets/learning_card.dart';
import 'package:dapple/features/home/presentation/widgets/xp_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "John";
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/avatar/1.svg",
              height: 36,
            ),
            const SizedBox(width: 8),
            Text("Hi $name!", style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            XpIcon(),
            // const SizedBox(width: 8,)
          ],
        ),
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18,
              ),
              LearningCard(),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Features",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeaturesIcon(),
                  FeaturesIcon(),
                  FeaturesIcon(),
                  FeaturesIcon(),
                ],
              )
            ],
          )),
    );
  }
}
