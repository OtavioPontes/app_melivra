import 'package:bloc/bloc.dart';

class UserBloc extends Bloc {
  UserBloc() : super(UserEmptyState()) {
    on<UserLoadingEvent>(handleUserLoadingEvent);
    on<UserSuccessEvent>(handleUserSuccessEvent);
    on<UserFailureEvent>(handleUserFailureEvent);
  }

  void handleUserLoadingEvent(UserLoadingEvent event, Emitter emit) {
    emit(UserLoadingState());
  }

  void handleUserSuccessEvent(UserSuccessEvent event, Emitter emit) {
    emit(UserSuccessState());
  }

  void handleUserFailureEvent(UserFailureEvent event, Emitter emit) {
    emit(UserFailureState(message: event.message));
  }
}

abstract class UserState {}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {}

class UserFailureState extends UserState {
  final String message;

  UserFailureState({required this.message});
}

abstract class UserEvent {}

class UserLoadingEvent extends UserEvent {}

class UserSuccessEvent extends UserEvent {}

class UserFailureEvent extends UserEvent {
  final String message;

  UserFailureEvent({required this.message});
}
