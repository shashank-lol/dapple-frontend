import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/cubits/app_user/app_user_cubit.dart';
import '../../../home/presentation/widgets/course_card.dart';
import '../../../home/presentation/widgets/features_icon.dart';
import '../../../home/presentation/new_widgets/learning_card.dart';
import '../../../home/presentation/widgets/xp_icon.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text("Hi ${userProvider.user.firstName}!",
                style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            XpIcon(userProvider.user.xp),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
