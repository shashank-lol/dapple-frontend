import 'package:dapple/core/cubits/app_user/app_user_cubit.dart';
import 'package:dapple/core/routes/app_route_consts.dart';
import 'package:dapple/core/routes/stream_to_listenable.dart';
import 'package:dapple/features/auth/presentation/pages/auth_page.dart';
import 'package:dapple/core/widgets/main_layout_page.dart';
import 'package:dapple/features/expert_talk/presentation/pages/appointment_details.dart';
import 'package:dapple/features/expert_talk/presentation/pages/expert_info_screen.dart';
import 'package:dapple/features/home/presentation/pages/lessons_page.dart';
import 'package:dapple/features/onboarding/presentation/pages/start_screen.dart';
import 'package:dapple/features/question/domain/entities/subjective_question_answer.dart';
import 'package:dapple/features/question/domain/entities/voice_question.dart';
import 'package:dapple/features/question/presentation/pages/answer_report_screen.dart';
import 'package:dapple/features/question/domain/entities/objective_question.dart';
import 'package:dapple/features/question/domain/entities/subjective_question.dart';
import 'package:dapple/features/question/presentation/pages/audio_question_screen.dart';
import 'package:dapple/features/question/presentation/pages/end_section_screen.dart';
import 'package:dapple/features/question/presentation/pages/learning_screen.dart';
import 'package:dapple/features/question/presentation/pages/objective_question_screen.dart';
import 'package:dapple/features/question/presentation/pages/subjective_question_screen.dart';
import 'package:dapple/features/test_section/domain/entities/test_question.dart';
import 'package:dapple/features/test_section/presentation/pages/start_test_screen.dart';
import 'package:dapple/features/test_section/presentation/pages/test_question_report_screen.dart';
import 'package:dapple/features/test_section/presentation/pages/test_question_screen.dart';
import 'package:dapple/features/test_section/presentation/pages/test_report_screen.dart';
import 'package:dapple/init_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/domain/entities/section.dart';
import '../../features/onboarding/presentation/pages/get_started_page.dart';
import '../../features/question/domain/entities/lesson.dart';
import '../../features/question/presentation/pages/start_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    // initialLocation: '/onboarding',
    initialLocation: '/main-layout',
    refreshListenable:
        StreamToListenable([serviceLocator<AppUserCubit>().stream]),
    // redirect: (context, state) {
    //   final isAuthenticated =
    //       context.read<AppUserCubit>().state is AppUserLoggedIn;
    //   if (state.matchedLocation.contains('/main-layout') && !isAuthenticated) {
    //     return '/onboarding';
    //   } else if (isAuthenticated &&
    //       state.matchedLocation.contains('/onboarding')) {
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
        name: AppRouteConsts.mainLayout,
        builder: (context, state) => MainLayoutPage(
          isSectionDone: (state.extra as bool?),
        ),
      ),
      GoRoute(
        path: '/lesson',
        name: AppRouteConsts.lesson,
        builder: (context, state) => LessonsPage(
          lessonName: 'Social Communication',
          currentLevel: 2,
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
            final lesson = state.extra as Lesson;
            return LearningScreen(
              title: lesson.title!,
              content: lesson.content,
              imageUrl: lesson.imageUrl,
              lessonId: lesson.questionId,
              lessonXp: lesson.xp,
            );
          }),
      GoRoute(
          path: '/subjectiveQuestion',
          name: AppRouteConsts.subjectiveQuestion,
          builder: (context, state) {
            final question = state.extra as SubjectiveQuestion;
            return SubjectiveQuestionScreen(
              question: question.question!,
              questionId: question.questionId,
              maxXp: question.xp,
            );
          }),
      GoRoute(
          path: '/objectiveQuestion',
          name: AppRouteConsts.objectiveQuestion,
          builder: (context, state) {
            final question = state.extra as ObjectiveQuestion;
            return ObjectiveQuestionScreen(
              options: question.options,
              question: question.question!,
              imageUrl: question.imageUrl,
              questionId: question.questionId,
            );
          }),
      GoRoute(
          path: '/audioQuestion',
          name: AppRouteConsts.audioQuestion,
          builder: (context, state) {
            final question = state.extra as VoiceQuestion;
            return AudioQuestionScreen(
              question: question.question!,
              questionId: question.questionId,
              maxXp: question.xp,
            );
          }),
      GoRoute(
          path: '/answerReport/:maxXp',
          name: AppRouteConsts.answerReport,
          builder: (context, state) {
            final response = state.extra as SubjectiveQuestionAnswer;
            return AnswerReportScreen(
              response: response,
              maxXp: int.parse(state.pathParameters['maxXp']!),
            );
          }),
      GoRoute(
          path: '/endPage',
          name: AppRouteConsts.endPage,
          builder: (context, state) {
            return EndSectionScreen();
          }),
      GoRoute(
          path: '/startTestScreen',
          name: AppRouteConsts.startTestScreen,
          builder: (context, state) {
            return StartTestScreen(
              section: state.extra as Section,
            );
          }),
      GoRoute(
          path: '/testQuestionScreen/:sessionId/:sectionId',
          name: AppRouteConsts.testQuestionScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
                child: TestQuestionScreen(
                    question: state.extra as TestQuestion,
                    sessionId: state.pathParameters['sessionId']!,
                    sectionId: state.pathParameters['sectionId']!),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                            .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: '/testReportScreen',
          name: AppRouteConsts.testReportScreen,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return TestReportScreen(
              sessionId: extra['sessionId'],
              sectionId: extra['sectionId'],
            );
          }),
      GoRoute(
          path: '/testQuestionReportScreen',
          name: AppRouteConsts.testQuestionReportScreen,
          builder: (context, state) {
            Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
            return TestQuestionReportScreen(
              question: extra['question'],
              maxXp: extra['maxXp'],
              questionResult: extra['questionResult'],
            );
          }),
      GoRoute(
          path: '/expertInfoScreen',
          name: AppRouteConsts.expertInfoScreen,
          builder: (context, state) {
            return ExpertInfoScreen();
          }),
      GoRoute(
          path: '/appointmentDetails',
          name: AppRouteConsts.appointmentDetails,
          builder: (context, state) {
            return AppointmentDetails();
          }),
    ],
  );
}
