import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/utils/show_snackbar.dart';
import 'package:dapple/features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:dapple/features/onboarding/presentation/widgets/auth_button.dart';
import 'package:dapple/features/onboarding/presentation/widgets/options_button.dart';
import 'package:dapple/features/onboarding/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/option/option_bloc.dart';

class GetStartedPage extends StatefulWidget {
  GetStartedPage({super.key, required this.index});

  int index;

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final res = context.read<OnboardingBloc>().state as OnboardingSelected;
    final questions = res.questions;
    final selectedOptions =
        BlocProvider.of<OptionBloc>(context).state.selectedOptions;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            setState(() {
              if (widget.index > 0) {
                widget.index--;
              } else {
                Navigator.pop(context);
              }
            });
          },
        ),
        title: ProgressBar(factor: (widget.index + 1) / questions.length),
      ),
      body: Stack(
        children: [
          Image.asset("assets/auth-bg.png"),
          SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset("assets/dapple-girl/stand.png"),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppPalette.blackColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: radius,
                            bottomLeft: radius,
                            topRight: radius,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            questions[widget.index].question,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                for (int i = 0; i < questions[widget.index].options.length; i++)
                  OptionsButton(
                    optionText: questions[widget.index].options[i].text,
                    icon: questions[widget.index].options[i].icon,
                    questionIndex: widget.index,
                    optionIndex: i,
                    maxSelection: questions[widget.index].maxSelection,
                  ),

                const Spacer(),
                AuthButton(
                  buttonText: "CONTINUE",
                  isPrimary: true,
                  onTap: () {
                    if (selectedOptions[widget.index].isEmpty) {
                      showSnackBar(context, "Please select an option");
                      return;
                    }
                    if (widget.index < questions.length - 1) {
                      setState(() {
                        widget.index++;
                      });
                    } else {
                      GoRouter.of(context).pushNamed(AppRouteConsts.signUp, extra: true);
                    }
                  },
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
