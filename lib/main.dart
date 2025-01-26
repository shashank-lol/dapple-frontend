import 'package:dapple/core/theme/theme.dart';
import 'package:dapple/features/auth/data/remote/auth_data_source.dart';
import 'package:dapple/features/auth/data/repository/auth_repo_impl.dart';
import 'package:dapple/features/auth/domain/usecases/user_log_in_email.dart';
import 'package:dapple/features/auth/domain/usecases/user_sign_up.dart';
import 'package:dapple/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dapple/features/onboarding/data/local/onboarding_questions.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/routes/app_route_config.dart';
import 'features/onboarding/domain/usecases/get_onboarding_questions.dart';
import 'features/onboarding/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(
            getOnboardingQuestions: GetOnboardingQuestions(
              OnboardingQuestionsImpl(),
            ),
          ),
        ),
        BlocProvider(create: (context) => OptionBloc()),
        BlocProvider(
            create: (context) => AuthBloc(
                userLogInWithEmail: UserLogInWithEmail(
                    AuthRepoImpl(AuthDataSourceImpl(_auth))),
                userSignUp: UserSignUp(
                    AuthRepoImpl(AuthDataSourceImpl(_auth)))))
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
