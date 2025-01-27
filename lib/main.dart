import 'package:dapple/core/theme/theme.dart';
import 'package:dapple/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:dapple/init_dependencies.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider(create: (context) => serviceLocator<AuthBloc>())
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
