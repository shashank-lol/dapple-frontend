import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/features/auth/presentation/pages/auth_page.dart';
import 'package:dapple/features/main_layout/main_layout_page.dart';
import 'package:dapple/features/onboarding/presentation/pages/start_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/pages/get_started_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    // initialLocation: '/sign-up',
    initialLocation: '/onboarding',
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
