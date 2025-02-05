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
import 'package:dapple/features/home/data/repository/level_repo_impl.dart';
import 'package:dapple/features/home/domain/repository/level_repository.dart';
import 'package:dapple/features/home/presentation/bloc/levels/levels_cubit.dart';
import 'package:dapple/features/onboarding/data/local/onboarding_questions.dart';
import 'package:dapple/features/onboarding/domain/usecases/get_onboarding_questions.dart';
import 'package:dapple/features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
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
import 'features/home/domain/usecases/get_all_levels.dart';

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
  _initHome();

  _initAuth();
  _initOnboarding();
}

void _initHome() {
  serviceLocator.registerFactory<LevelDataSource>(() => LevelDataSourceImpl());
  serviceLocator
      .registerFactory<LevelLocalDataSource>(() => LevelLocalDataSourceImpl());
  serviceLocator.registerFactory<LevelRepository>(
      () => LevelRepoImpl(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => GetAllLevels(serviceLocator()));
  serviceLocator.registerLazySingleton<LevelsCubit>(
      () => LevelsCubit(getAllLevels: serviceLocator()));
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
