import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/core/routes/stream_to_listenable.dart';
import 'package:dapple/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dapple/features/auth/presentation/pages/auth_page.dart';
import 'package:dapple/features/main_layout/main_layout_page.dart';
import 'package:dapple/features/onboarding/presentation/pages/start_screen.dart';
import 'package:dapple/init_dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/pages/get_started_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    // initialLocation: '/sign-up',
    initialLocation: '/onboarding',
    refreshListenable: StreamToListenable([serviceLocator<AuthBloc>().stream]),
    redirect: (context, state){
      final isAuthenticated = context.read<AuthBloc>().state is AuthSuccess;
      if (state.matchedLocation.contains('/home') && !isAuthenticated) {
        return '/onboarding';
      }
      else if(isAuthenticated && state.matchedLocation.contains('/onboarding')){
        return '/main-layout';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        name: AppRouteConsts.onboarding,
        path: '/onboarding',
        builder: (context, state) => StartScreen(),
      ),
      GoRoute(
        path: '/get-started/:index',
        name: AppRouteConsts.getStarted,
        builder: (context, state) {
          final index = state.pathParameters['index']!;
          return GetStartedPage(index: int.parse(index));
        },
      ),
      GoRoute(
        path: '/sign-up',
        name: AppRouteConsts.signUp,
        builder: (context, state) => AuthPage(isNewUser: true),
      ),
      GoRoute(
        path: '/login',
        name: AppRouteConsts.login,
        builder: (context, state) => AuthPage(isNewUser: false),
      ),
      GoRoute(
        path: '/main-layout',
        name: AppRouteConsts.mainlayout,
        builder: (context, state) => MainLayoutPage(),
      ),
    ],
  );
}
