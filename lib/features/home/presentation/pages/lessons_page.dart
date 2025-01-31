import 'package:dapple/features/home/presentation/data/levelstatus.dart';
import 'package:dapple/features/home/presentation/widgets/level_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/cubits/app_user/app_user_cubit.dart';
import '../widgets/xp_icon.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage(
      {super.key, required this.lessonname, required this.currentlevel});

  final String lessonname;
  final int currentlevel;

  @override
  Widget build(BuildContext context) {
    final userCubit = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: (){
                GoRouter.of(context).pop();
              },
              child: SvgPicture.asset(
                "assets/buttons/back.svg",
                height: 18,
              ),
            ),
            const SizedBox(width: 8),
            Text(lessonname, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            XpIcon(userCubit.xp),
            // const SizedBox(width: 8,)
          ],
        ),
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 18),
          child: ListView.builder(
            itemCount: 10, // Number of items
            itemBuilder: (context, index) {
              return LevelWidget(
                heading: 'Travel newbie',
                status: getLevelStatus(currentlevel, index),
                currentlevel: currentlevel,
                description:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting',
                level: index+1,
              );
            },
          )),
    );
  }

  LevelStatus getLevelStatus(int currentLevel, int index) {
    index++;
    return index < currentLevel
        ? LevelStatus.completed
        : index == currentLevel
            ? LevelStatus.current
            : LevelStatus.locked;
  }
}
