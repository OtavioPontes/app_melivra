abstract class LoginState {}

class LoginEmptyState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState({
    required this.message,
  });
}

class LoginLoadingState extends LoginState {}
