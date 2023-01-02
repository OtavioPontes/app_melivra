import 'package:bloc/bloc.dart';

class ShowEvaluationButtonBloc extends Bloc {
  ShowEvaluationButtonBloc() : super(ShowEvaluationButtonEmptyState()) {
    on<ShowEvaluationButtonLoadingEvent>(
        handleShowEvaluationButtonLoadingEvent);
    on<ShowEvaluationButtonSuccessEvent>(
        handleShowEvaluationButtonSuccessEvent);
    on<ShowEvaluationButtonFailureEvent>(
        handleShowEvaluationButtonFailureEvent);
    on<ShowEvaluationButtonResetEvent>(handleShowEvaluationButtonResetEvent);
  }

  void handleShowEvaluationButtonLoadingEvent(
      ShowEvaluationButtonLoadingEvent event, Emitter emit) {
    emit(ShowEvaluationButtonLoadingState());
  }

  void handleShowEvaluationButtonSuccessEvent(
      ShowEvaluationButtonSuccessEvent event, Emitter emit) {
    emit(ShowEvaluationButtonSuccessState());
  }

  void handleShowEvaluationButtonFailureEvent(
      ShowEvaluationButtonFailureEvent event, Emitter emit) {
    emit(ShowEvaluationButtonFailureState(message: event.message));
  }

  void handleShowEvaluationButtonResetEvent(
      ShowEvaluationButtonResetEvent event, Emitter emit) {
    emit(ShowEvaluationButtonEmptyState());
  }
}

abstract class ShowEvaluationButtonState {}

class ShowEvaluationButtonEmptyState extends ShowEvaluationButtonState {}

class ShowEvaluationButtonLoadingState extends ShowEvaluationButtonState {}

class ShowEvaluationButtonSuccessState extends ShowEvaluationButtonState {}

class ShowEvaluationButtonFailureState extends ShowEvaluationButtonState {
  final String message;

  ShowEvaluationButtonFailureState({required this.message});
}

abstract class ShowEvaluationButtonEvent {}

class ShowEvaluationButtonLoadingEvent extends ShowEvaluationButtonEvent {}

class ShowEvaluationButtonSuccessEvent extends ShowEvaluationButtonEvent {}

class ShowEvaluationButtonFailureEvent extends ShowEvaluationButtonEvent {
  final String message;

  ShowEvaluationButtonFailureEvent({required this.message});
}

class ShowEvaluationButtonResetEvent extends ShowEvaluationButtonEvent {}
