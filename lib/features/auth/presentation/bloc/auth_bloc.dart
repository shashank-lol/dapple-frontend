import 'package:dapple/core/cubits/app_user/app_user_cubit.dart';
import 'package:dapple/core/entities/user.dart';
import 'package:dapple/features/auth/domain/usecases/current_user.dart';
import 'package:dapple/features/auth/domain/usecases/google_sign_in.dart';
import 'package:dapple/features/auth/domain/usecases/google_sign_up.dart';
import 'package:dapple/features/auth/domain/usecases/user_log_in_email.dart';
import 'package:dapple/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogInWithEmail _userLogInWithEmail;
  final LoginWithGoogle _loginWithGoogle;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final SignUpWithGoogle _signUpWithGoogle;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogInWithEmail userLogInWithEmail,
      required LoginWithGoogle loginWithGoogle,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit,
      required SignUpWithGoogle signUpWithGoogle})
      : _userSignUp = userSignUp,
        _userLogInWithEmail = userLogInWithEmail,
        _loginWithGoogle = loginWithGoogle,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _signUpWithGoogle = signUpWithGoogle,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      await _userSignUp(UserSignUpParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        age: event.age,
        gender: event.gender,
        profession: event.profession,
        socialChallenges: event.socialChallenges,
        socialSettings: event.socialSettings,
      )).then((result) {
        result.fold(
          (failure) async => emit(AuthFailure(failure.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      });
    });

    on<AuthLogInWithEmail>((event, emit) async {
      emit(AuthLoading());
      await _userLogInWithEmail(UserLogInEmailParams(
        email: event.email,
        password: event.password,
      )).then((result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      });
    });

    on<AuthLogInWithGoogle>((event, emit) async {
      emit(AuthLoading());
      await _loginWithGoogle(true).then((result) {
        result.fold(
          (failure) async => emit(AuthFailure(failure.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      });
    });

    on<AuthSignUpWithGoogle>((event, emit) async {
      emit(AuthLoading());
      await _signUpWithGoogle(GoogleSignUpParams(
        age: event.age,
        gender: event.gender,
        profession: event.profession,
        socialChallenges: event.socialChallenges,
        socialSettings: event.socialSettings,
      )).then((result) {
        result.fold(
          (failure) async => emit(AuthFailure(failure.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      });
    });

    on<AuthCurrentUser>((event, emit) async {
      emit(AuthLoading());
      await _currentUser(true).then((result) => result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user) => _emitAuthSuccess(user, emit)));
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
