import 'package:dapple/core/cubits/app_user/app_user_cubit.dart';
import 'package:dapple/features/auth/data/local/user_data_source.dart';
import 'package:dapple/features/auth/data/remote/auth_data_source.dart';
import 'package:dapple/features/auth/data/repository/auth_repo_impl.dart';
import 'package:dapple/features/auth/domain/repository/auth_repository.dart';
import 'package:dapple/features/auth/domain/usecases/google_sign_in.dart';
import 'package:dapple/features/auth/domain/usecases/user_log_in_email.dart';
import 'package:dapple/features/auth/domain/usecases/user_sign_up.dart';
import 'package:dapple/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dapple/features/home/data/remote/level_data_source.dart';
import 'package:dapple/features/home/data/remote/xp_data_source.dart';
import 'package:dapple/features/home/data/repository/level_repo_impl.dart';
import 'package:dapple/features/home/data/repository/user_repo_impl.dart';
import 'package:dapple/features/home/domain/repository/level_repository.dart';
import 'package:dapple/features/home/domain/repository/user_repository.dart';
import 'package:dapple/features/home/domain/usecases/update_xp.dart';
import 'package:dapple/features/home/presentation/bloc/levels/levels_cubit.dart';
import 'package:dapple/features/home/presentation/bloc/xp_server/xp_server_cubit.dart';
import 'package:dapple/features/onboarding/data/local/onboarding_questions.dart';
import 'package:dapple/features/onboarding/domain/usecases/get_onboarding_questions.dart';
import 'package:dapple/features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:dapple/features/question/data/remote/questions_remote_data_source.dart';
import 'package:dapple/features/question/data/repository/questions_repo_impl.dart';
import 'package:dapple/features/question/domain/repository/questions_repository.dart';
import 'package:dapple/features/question/domain/usecases/answer_objective_question.dart';
import 'package:dapple/features/question/domain/usecases/get_all_questions.dart';
import 'package:dapple/features/question/domain/usecases/mark_lesson_completed.dart';
import 'package:dapple/features/question/presentation/bloc/all_questions/questions_cubit.dart';
import 'package:dapple/features/question/presentation/bloc/question_complete/question_complete_bloc.dart';
import 'package:dapple/features/test_section/data/remote/socket_data_source.dart';
import 'package:dapple/features/test_section/data/remote/test_data_source.dart';
import 'package:dapple/features/test_section/data/repository/socket_repo_impl.dart';
import 'package:dapple/features/test_section/data/repository/test_repo_impl.dart';
import 'package:dapple/features/test_section/domain/repository/socket_repository.dart';
import 'package:dapple/features/test_section/domain/repository/test_repository.dart';
import 'package:dapple/features/test_section/domain/usecases/get_test_questions.dart';
import 'package:dapple/features/test_section/domain/usecases/get_test_result.dart';
import 'package:dapple/features/test_section/domain/usecases/init_socket.dart';
import 'package:dapple/features/test_section/domain/usecases/send_image.dart';
import 'package:dapple/features/test_section/presentation/bloc/socket/socket_bloc.dart';
import 'package:dapple/features/test_section/presentation/bloc/test_questions/test_questions_cubit.dart';
import 'core/cubits/xp/xp_cubit.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/google_sign_up.dart';
import 'features/home/data/local/level_local_data_source.dart';
import 'features/home/data/local/user_local_data.dart';
import 'features/home/domain/usecases/get_all_levels.dart';
import 'features/question/domain/usecases/answer_subjective_question.dart';
import 'features/question/domain/usecases/answer_voice_question.dart';
import 'features/question/domain/usecases/subjective_hint.dart';
import 'features/test_section/data/local/local_test_questions.dart';
import 'features/test_section/domain/usecases/close_socket.dart';
import 'features/test_section/domain/usecases/retry_answer.dart';
import 'features/test_section/domain/usecases/send_answer.dart';
import 'features/test_section/presentation/bloc/result/result_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");
  await EncryptedSharedPreferences.initialize(
      dotenv.env['SECRET_KEY'] ?? "0000000000000000");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final sharedPref = EncryptedSharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<FirebaseAuth>(() => auth);
  serviceLocator.registerLazySingleton<GoogleSignIn>(() => googleSignIn);
  serviceLocator
      .registerLazySingleton<EncryptedSharedPreferences>(() => sharedPref);

  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

  _initHome(sharedPref);

  _initAuth();
  _initOnboarding();
  _initQuestions();
  _initSection();
  _initTest();
}

void _initTest() {
  serviceLocator
    ..registerFactory<TestDataSource>(
        () => TestDataSourceImpl(serviceLocator()))
    ..registerFactory<TestQuestionsLocal>(() => TestQuestionsLocalImpl())
    ..registerFactory<TestRepository>(() => TestQuestionsRepoImpl(
        testQuestionsDataSource: serviceLocator(),
        testQuestionsLocal: serviceLocator()))
    ..registerFactory(() => GetTestQuestion(serviceLocator()))
    ..registerLazySingleton(
        () => TestQuestionsCubit(getTestQuestion: serviceLocator()))
    ..registerFactory<SocketDataSource>(
        () => SocketDataSourceImpl(serviceLocator()))
    ..registerFactory<SocketRepository>(
        () => SocketRepositoryImpl(serviceLocator()))
    ..registerFactory(() => InitSocket(serviceLocator()))
    ..registerFactory(() => SendImage(serviceLocator()))
    ..registerFactory(() => SendAnswer(serviceLocator()))
    ..registerFactory(() => CloseSocket(serviceLocator()))
    ..registerFactory(() => RetryAnswer(serviceLocator()))
    ..registerLazySingleton(() => SocketBloc(
        initSocket: serviceLocator(),
        sendImage: serviceLocator(),
        sendAnswer: serviceLocator(),
        closeSocket: serviceLocator(),
        retryAnswer: serviceLocator()))
    ..registerFactory(() => GetTestResult(serviceLocator()))
    ..registerLazySingleton(() => ResultCubit(serviceLocator()));
}

void _initSection() {
  serviceLocator
    ..registerFactory(() => MarkLessonCompleted(serviceLocator()))
    ..registerFactory(() => AnswerObjectiveQuestion(serviceLocator()))
    ..registerFactory(() => AnswerSubjectiveQuestion(serviceLocator()))
    ..registerFactory(() => SubjectiveHint(serviceLocator()))
    ..registerFactory(() => AnswerVoiceQuestion(serviceLocator()))
    ..registerLazySingleton(() => QuestionCompleteBloc(
        markLessonCompleted: serviceLocator(),
        answerObjectiveQuestion: serviceLocator(),
        answerSubjectiveQuestion: serviceLocator(),
        subjectiveHint: serviceLocator(),
        answerVoiceQuestion: serviceLocator()));
}

void _initQuestions() {
  serviceLocator.registerFactory<QuestionsRemoteDataSource>(
      () => QuestionsRemoteDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<QuestionsRepository>(
      () => QuestionsRepoImpl(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllQuestions(serviceLocator()));
  serviceLocator.registerLazySingleton<QuestionsCubit>(
      () => QuestionsCubit(getAllQuestions: serviceLocator()));
}

void _initHome(EncryptedSharedPreferences sharedPref) {
  serviceLocator
    ..registerFactory<LevelDataSource>(() => LevelDataSourceImpl(sharedPref))
    ..registerFactory<LevelLocalDataSource>(() => LevelLocalDataSourceImpl())
    ..registerFactory<LevelRepository>(
        () => LevelRepoImpl(serviceLocator(), serviceLocator()))
    ..registerFactory(() => GetAllLevels(serviceLocator()))
    ..registerLazySingleton<LevelsCubit>(
        () => LevelsCubit(getAllLevels: serviceLocator()))
    ..registerFactory<UserLocalData>(() => UserLocalDataImpl(serviceLocator()))
    ..registerFactory<XpDataSource>(() => XpDataSourceImpl(serviceLocator()))
    ..registerFactory<UserRepository>(
        () => UserRepoImpl(serviceLocator(), serviceLocator()))
    ..registerFactory(() => UpdateXp(serviceLocator()))
    ..registerLazySingleton(() => XpCubit(serviceLocator()))
    ..registerLazySingleton(() => XpServerCubit(updateXp: serviceLocator()));
}

void _initAuth() {
  serviceLocator
    // Auth Data Source
    ..registerFactory<UserDataSource>(() => UserDataSourceImpl(
          serviceLocator<EncryptedSharedPreferences>(),
        ))
    ..registerFactory<AuthDataSource>(() => AuthDataSourceImpl(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    // Auth Repository
    ..registerFactory<AuthRepository>(() => AuthRepoImpl(
          serviceLocator(),
          serviceLocator(),
        ))
    // Use Cases
    ..registerFactory(() => UserSignUp(
          serviceLocator(),
        ))
    ..registerFactory(() => UserLogInWithEmail(
          serviceLocator(),
        ))
    ..registerFactory(() => LoginWithGoogle(
          serviceLocator(),
        ))
    ..registerFactory(() => SignUpWithGoogle(
          serviceLocator(),
        ))
    ..registerFactory(() => CurrentUser(
          serviceLocator(),
        ))
    // Bloc
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userLogInWithEmail: serviceLocator(),
          loginWithGoogle: serviceLocator(),
          signUpWithGoogle: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}

void _initOnboarding() {
  serviceLocator
    ..registerFactory(
      () => OnboardingQuestionsImpl(),
    )
    ..registerFactory(() => GetOnboardingQuestions(
          serviceLocator<OnboardingQuestionsImpl>(),
        ))
    ..registerLazySingleton(() => OnboardingBloc(
          getOnboardingQuestions: serviceLocator(),
        ))
    ..registerFactory(() => OptionBloc());
}
