import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/entities/questions.dart';
import '../../../onboarding/presentation/bloc/option/option_bloc.dart';
import '../bloc/auth_bloc.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton(this.isSignUp,{super.key});

  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if(!isSignUp) {
          BlocProvider.of<AuthBloc>(context).add(AuthLogInWithGoogle());
        }
        else {
          final optionBloc = BlocProvider.of<OptionBloc>(
            context,
          );
          final int age =
          optionBloc.state.selectedOptions[0][0];
          final int gender =
          optionBloc.state.selectedOptions[1][0];
          final int profession =
          optionBloc.state.selectedOptions[2][0];
          final List<int> socialChallenges =
          optionBloc.state.selectedOptions[3];
          final List<int> socialSettings =
          optionBloc.state.selectedOptions[4];

          BlocProvider.of<AuthBloc>(context).add(
            AuthSignUpWithGoogle(
              age: ages[age],
              gender: genders[gender],
              profession: professions[profession],
              socialChallenges: socialChallenges
                  .map((e) => challenges[e])
                  .toList(),
              socialSettings: socialSettings
                  .map((e) => socialSituations[e])
                  .toList(),
            ),
          );

        }
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
