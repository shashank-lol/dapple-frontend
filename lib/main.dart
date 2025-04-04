import 'package:dapple/core/theme/theme.dart';
import 'package:dapple/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dapple/features/expert_talk/presentation/bloc/appointments/appointments_cubit.dart';
import 'package:dapple/features/expert_talk/presentation/bloc/experts/experts_cubit.dart';
import 'package:dapple/features/home/presentation/bloc/levels/levels_cubit.dart';
import 'package:dapple/features/home/presentation/bloc/xp_server/xp_server_cubit.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:dapple/features/question/presentation/bloc/question_complete/question_complete_bloc.dart';
import 'package:dapple/features/test_section/presentation/bloc/result/result_cubit.dart';
import 'package:dapple/features/test_section/presentation/bloc/socket/socket_bloc.dart';
import 'package:dapple/features/test_section/presentation/bloc/test_questions/test_questions_cubit.dart';
import 'package:dapple/init_dependencies.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubits/xp/xp_cubit.dart';
import 'core/cubits/app_user/app_user_cubit.dart';
import 'core/routes/app_route_config.dart';
import 'features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';

void main() async {
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (context) => serviceLocator<OnboardingBloc>()),
        BlocProvider(create: (context) => serviceLocator<OptionBloc>()),
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<LevelsCubit>()),
        BlocProvider(create: (context) => serviceLocator<QuestionsCubit>()),
        BlocProvider(
            create: (context) => serviceLocator<QuestionCompleteBloc>()),
        BlocProvider(create: (context) => serviceLocator<XpCubit>()),
        BlocProvider(create: (context) => serviceLocator<XpServerCubit>()),
        BlocProvider(create: (context) => serviceLocator<TestQuestionsCubit>()),
        BlocProvider(create: (context) => serviceLocator<SocketBloc>()),
        BlocProvider(create: (context) => serviceLocator<ResultCubit>()),
        BlocProvider(create: (context) => serviceLocator<ExpertsCubit>()),
        BlocProvider(create: (context) => serviceLocator<AppointmentsCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCurrentUser());
  }

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
