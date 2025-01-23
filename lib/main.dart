import 'package:dapple/core/theme/theme.dart';
import 'package:dapple/features/onboarding/data/local/onboarding_questions.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_route_config.dart';
import 'features/onboarding/domain/usecases/get_onboarding_questions.dart';
import 'features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => OnboardingBloc(
                getOnboardingQuestions: GetOnboardingQuestions(
                  OnboardingQuestionsImpl(),
                ),
              ),
        ),
        BlocProvider(create: (context) => OptionBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dapple',
      routerConfig: AppRouter().router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
    );
  }
}
