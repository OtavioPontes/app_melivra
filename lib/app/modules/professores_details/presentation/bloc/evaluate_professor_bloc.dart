import 'package:bloc/bloc.dart';

class EvaluateProfessorBloc extends Bloc {
  EvaluateProfessorBloc() : super(EvaluateProfessorEmptyState()) {
    on<EvaluateProfessorLoadingEvent>(handleEvaluateProfessorLoadingEvent);
    on<EvaluateProfessorSuccessEvent>(handleEvaluateProfessorSuccessEvent);
    on<EvaluateProfessorFailureEvent>(handleEvaluateProfessorFailureEvent);
    on<EvaluateProfessorResetEvent>(handleEvaluateProfessorResetEvent);
  }

  void handleEvaluateProfessorLoadingEvent(
      EvaluateProfessorLoadingEvent event, Emitter emit) {
    emit(EvaluateProfessorLoadingState());
  }

  void handleEvaluateProfessorSuccessEvent(
      EvaluateProfessorSuccessEvent event, Emitter emit) {
    emit(EvaluateProfessorSuccessState());
  }

  void handleEvaluateProfessorFailureEvent(
      EvaluateProfessorFailureEvent event, Emitter emit) {
    emit(EvaluateProfessorFailureState(message: event.message));
  }

  void handleEvaluateProfessorResetEvent(
      EvaluateProfessorResetEvent event, Emitter emit) {
    emit(EvaluateProfessorEmptyState());
  }
}

abstract class EvaluateProfessorState {}

class EvaluateProfessorEmptyState extends EvaluateProfessorState {}

class EvaluateProfessorLoadingState extends EvaluateProfessorState {}

class EvaluateProfessorSuccessState extends EvaluateProfessorState {}

class EvaluateProfessorFailureState extends EvaluateProfessorState {
  final String message;

  EvaluateProfessorFailureState({required this.message});
}

abstract class EvaluateProfessorEvent {}

class EvaluateProfessorLoadingEvent extends EvaluateProfessorEvent {}

class EvaluateProfessorSuccessEvent extends EvaluateProfessorEvent {}

class EvaluateProfessorFailureEvent extends EvaluateProfessorEvent {
  final String message;

  EvaluateProfessorFailureEvent({required this.message});
}

class EvaluateProfessorResetEvent extends EvaluateProfessorEvent {}
