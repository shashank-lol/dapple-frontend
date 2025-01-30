import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          final List<int> selectedCoursesInd = optionBloc
              .state.selectedOptions[0];
          final int age = optionBloc.state.selectedOptions[1]
              .isNotEmpty
              ? optionBloc.state.selectedOptions[1][0]
              : 0;

          BlocProvider.of<AuthBloc>(context).add(
            AuthSignUpWithGoogle(
              courses: selectedCoursesInd,
              age: age,
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
