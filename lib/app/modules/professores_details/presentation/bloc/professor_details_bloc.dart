import 'package:bloc/bloc.dart';

import '../../../professores/domain/entities/professor_entity.dart';

class ProfessorDetailsBloc extends Bloc {
  ProfessorDetailsBloc() : super(ProfessorDetailsEmptyState()) {
    on<ProfessorDetailsLoadingEvent>(handleProfessorDetailsLoadingEvent);
    on<ProfessorDetailsSuccessEvent>(handleProfessorDetailsSuccessEvent);
    on<ProfessorDetailsFailureEvent>(handleProfessorDetailsFailureEvent);
  }

  void handleProfessorDetailsLoadingEvent(
      ProfessorDetailsLoadingEvent event, Emitter emit,) {
    emit(ProfessorDetailsLoadingState());
  }

  void handleProfessorDetailsSuccessEvent(
      ProfessorDetailsSuccessEvent event, Emitter emit,) {
    emit(ProfessorDetailsSuccessState(professor: event.professor));
  }

  void handleProfessorDetailsFailureEvent(
      ProfessorDetailsFailureEvent event, Emitter emit,) {
    emit(ProfessorDetailsFailureState(message: event.message));
  }
}

abstract class ProfessorDetailsState {}

class ProfessorDetailsEmptyState extends ProfessorDetailsState {}

class ProfessorDetailsLoadingState extends ProfessorDetailsState {}

class ProfessorDetailsSuccessState extends ProfessorDetailsState {
  final Professor professor;
  ProfessorDetailsSuccessState({
    required this.professor,
  });
}

class ProfessorDetailsFailureState extends ProfessorDetailsState {
  final String message;

  ProfessorDetailsFailureState({required this.message});
}

abstract class ProfessorDetailsEvent {}

class ProfessorDetailsLoadingEvent extends ProfessorDetailsEvent {}

class ProfessorDetailsSuccessEvent extends ProfessorDetailsEvent {
  final Professor professor;
  ProfessorDetailsSuccessEvent({
    required this.professor,
  });
}

class ProfessorDetailsFailureEvent extends ProfessorDetailsEvent {
  final String message;

  ProfessorDetailsFailureEvent({required this.message});
}
