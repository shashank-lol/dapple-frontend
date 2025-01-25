import 'package:bloc/bloc.dart';
import 'package:dapple/features/auth/domain/usecases/user_log_in_email.dart';
import 'package:dapple/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogInWithEmail _userLogInWithEmail;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogInWithEmail userLogInWithEmail})
      : _userSignUp = userSignUp,
        _userLogInWithEmail = userLogInWithEmail,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) {
      _userSignUp(UserSignUpParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
      )).then((result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (message) => emit(AuthSuccess(message)),
        );
      });
    });

    on<AuthLogInWithEmail>((event, emit) {
      _userLogInWithEmail(UserLogInEmailParams(
        email: event.email,
        password: event.password,
      )).then((result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (message) => emit(AuthSuccess(message)),
        );
      });
    });
  }
}
