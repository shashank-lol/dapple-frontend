import 'package:dapple/core/cubits/app_user/app_user_cubit.dart';
import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/core/routes/stream_to_listenable.dart';
import 'package:dapple/features/auth/presentation/pages/auth_page.dart';
import 'package:dapple/core/widgets/main_layout_page.dart';
import 'package:dapple/features/home/presentation/pages/lessons_page.dart';
import 'package:dapple/features/onboarding/presentation/pages/start_screen.dart';
import 'package:dapple/features/question/presentation/pages/learning_screen.dart';
import 'package:dapple/features/question/presentation/pages/objective_question_screen.dart';
import 'package:dapple/features/question/presentation/pages/subjective_question_screen.dart';
import 'package:dapple/features/question/presentation/pages/start_page.dart';
import 'package:dapple/init_dependencies.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/domain/entities/section.dart';
import '../../features/onboarding/presentation/pages/get_started_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    // initialLocation: '/onboarding',
    initialLocation: '/main-layout',
    refreshListenable:
        StreamToListenable([serviceLocator<AppUserCubit>().stream]),
    // redirect: (context, state){
    //   final isAuthenticated = context.read<AppUserCubit>().state is AppUserLoggedIn;
    //   if (state.matchedLocation.contains('/main-layout') && !isAuthenticated) {
    //     return '/onboarding';
    //   }
    //   else if(isAuthenticated && state.matchedLocation.contains('/onboarding')){
    //     return '/main-layout';
    //   }
    //   return null;
    // },
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
      GoRoute(
        path: '/lesson',
        name: AppRouteConsts.lesson,
        builder: (context, state) => LessonsPage(
          lessonname: 'Social Communication',
          currentlevel: 2,
        ),
      ),
      GoRoute(
          path: '/section',
          name: AppRouteConsts.section,
          builder: (context, state) {
            return StartPage(state.extra as Section);
          }),
      GoRoute(
          path: '/learn',
          name: AppRouteConsts.learn,
          builder: (context, state) {
            return Learningscreen();
          }),
      GoRoute(
          path: '/subjectiveQuestion',
          name: AppRouteConsts.subjectiveQuestionScreen,
          builder: (context, state) {
            return SubjectiveQuestionScreen();
          }),
      GoRoute(
          path: '/objectiveQuestion',
          name: AppRouteConsts.objectiveQuestionScreen,
          builder: (context, state) {
            return ObjectiveQuestionScreen();
          }),
    ],
  );
}
