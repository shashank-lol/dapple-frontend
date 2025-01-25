import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:dapple/features/onboarding/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/logo/app_logo.dart';
import '../../../../core/widgets/logo/dapple_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFE8E5FA),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            AppLogo(),
            const SizedBox(height: 8),
            DappleText(),
            const SizedBox(height: 24),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Image.asset(
                  'assets/dapple-girl/hi.png',
                  height: deviceHeight / 2.5,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 250,
        decoration: BoxDecoration(
          // color: Color(0xFFE8E5FA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 4,
              blurRadius: 30,
              offset: Offset(0, -2),
            ),
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome to Thrive Together",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                "Discover tools to enhance social skills and improve focus, tailored for YOU!",

                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AuthButton(
                buttonText: 'Get Started'.toUpperCase(),
                isPrimary: true,
                onTap: () {
                  context.read<OnboardingBloc>().add(GetStarted());
                  GoRouter.of(context).pushNamed(
                    AppRouteConsts.getStarted,
                    pathParameters: {'index': '0'},
                  );
                },
              ),
              const SizedBox(height: 16),
              AuthButton(
                buttonText: 'I Already have an account'.toUpperCase(),
                isPrimary: false,
                onTap: () {
                  GoRouter.of(context).pushNamed(AppRouteConsts.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
