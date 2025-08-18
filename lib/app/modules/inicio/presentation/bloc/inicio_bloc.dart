abstract class InicioBlocState {}

class InicioBlocEmptyState extends InicioBlocState {}

class InicioBlocLoadingState extends InicioBlocState {}

class InicioBlocSuccessState extends InicioBlocState {}

class InicioBlocFailureState extends InicioBlocState {
  final String message;
  InicioBlocFailureState({
    required this.message,
  });
}

abstract class InicioBlocEvent {}

class InicioBlocSignInEvent extends InicioBlocEvent {
  final String idToken;
  InicioBlocSignInEvent({
    required this.idToken,
  });
}
