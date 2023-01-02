import 'package:app_melivra/app/core/domain/entities/grade_response.dart';
import 'package:bloc/bloc.dart';

class ProfessorGradesBloc extends Bloc {
  ProfessorGradesBloc() : super(ProfessorGradesEmptyState()) {
    on<ProfessorGradesLoadingEvent>(handleProfessorGradesLoadingEvent);
    on<ProfessorGradesSuccessEvent>(handleProfessorGradesSuccessEvent);
    on<ProfessorGradesFailureEvent>(handleProfessorGradesFailureEvent);
  }

  void handleProfessorGradesLoadingEvent(
      ProfessorGradesLoadingEvent event, Emitter emit) {
    emit(ProfessorGradesLoadingState());
  }

  void handleProfessorGradesSuccessEvent(
      ProfessorGradesSuccessEvent event, Emitter emit) {
    emit(ProfessorGradesSuccessState(grades: event.grades));
  }

  void handleProfessorGradesFailureEvent(
      ProfessorGradesFailureEvent event, Emitter emit) {
    emit(ProfessorGradesFailureState(message: event.message));
  }
}

abstract class ProfessorGradesState {}

class ProfessorGradesEmptyState extends ProfessorGradesState {}

class ProfessorGradesLoadingState extends ProfessorGradesState {}

class ProfessorGradesSuccessState extends ProfessorGradesState {
  final List<GradeResponse> grades;
  ProfessorGradesSuccessState({
    required this.grades,
  });
}

class ProfessorGradesFailureState extends ProfessorGradesState {
  final String message;

  ProfessorGradesFailureState({required this.message});
}

abstract class ProfessorGradesEvent {}

class ProfessorGradesLoadingEvent extends ProfessorGradesEvent {}

class ProfessorGradesSuccessEvent extends ProfessorGradesEvent {
  final List<GradeResponse> grades;
  ProfessorGradesSuccessEvent({
    required this.grades,
  });
}

class ProfessorGradesFailureEvent extends ProfessorGradesEvent {
  final String message;

  ProfessorGradesFailureEvent({required this.message});
}
