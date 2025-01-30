import 'package:dapple/features/home/presentation/widgets/course_card.dart';
import 'package:dapple/features/home/presentation/widgets/features_icon.dart';
import 'package:dapple/features/home/presentation/widgets/learning_card.dart';
import 'package:dapple/features/home/presentation/widgets/xp_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/cubits/app_user/app_user_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "John";
    final userProvider = context.read<AppUserCubit>().state as AppUserLoggedIn;
    print(userProvider.user.enrolledCourses.toString());
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
      body: SingleChildScrollView(
        child: SafeArea(
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
                    FeaturesIcon("assets/features/chat.png"),
                    FeaturesIcon("assets/features/focus.png"),
                    FeaturesIcon("assets/features/task.png"),
                    FeaturesIcon("assets/features/eye.png"),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Popular Courses",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    for (var course in userProvider.user.enrolledCourses!)
                      CourseCard(
                        name: course,
                      )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
