abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {}

class LoginSuccessResponseEvent extends LoginEvent {}

class LoginFailureResponseEvent extends LoginEvent {
  final String message;
  LoginFailureResponseEvent({
    required this.message,
  });
}
