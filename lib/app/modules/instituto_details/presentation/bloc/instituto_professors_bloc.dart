import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:bloc/bloc.dart';

class InstitutoProfessorsBloc extends Bloc {
  InstitutoProfessorsBloc() : super(InstitutoProfessorsEmptyState()) {
    on<InstitutoProfessorsLoadingEvent>(handleInstitutoProfessorsLoadingEvent);
    on<InstitutoProfessorsSuccessEvent>(handleInstitutoProfessorsSuccessEvent);
    on<InstitutoProfessorsFailureEvent>(handleInstitutoProfessorsFailureEvent);
  }

  void handleInstitutoProfessorsLoadingEvent(
      InstitutoProfessorsLoadingEvent event, Emitter emit,) {
    emit(InstitutoProfessorsLoadingState());
  }

  void handleInstitutoProfessorsSuccessEvent(
      InstitutoProfessorsSuccessEvent event, Emitter emit,) {
    emit(InstitutoProfessorsSuccessState(professor: event.professor));
  }

  void handleInstitutoProfessorsFailureEvent(
      InstitutoProfessorsFailureEvent event, Emitter emit,) {
    emit(InstitutoProfessorsFailureState(message: event.message));
  }
}

abstract class InstitutoProfessorsState {}

class InstitutoProfessorsEmptyState extends InstitutoProfessorsState {}

class InstitutoProfessorsLoadingState extends InstitutoProfessorsState {}

class InstitutoProfessorsSuccessState extends InstitutoProfessorsState {
  final List<Professor> professor;
  InstitutoProfessorsSuccessState({
    required this.professor,
  });
}

class InstitutoProfessorsFailureState extends InstitutoProfessorsState {
  final String message;

  InstitutoProfessorsFailureState({required this.message});
}

abstract class InstitutoProfessorsEvent {}

class InstitutoProfessorsLoadingEvent extends InstitutoProfessorsEvent {}

class InstitutoProfessorsSuccessEvent extends InstitutoProfessorsEvent {
  final List<Professor> professor;
  InstitutoProfessorsSuccessEvent({
    required this.professor,
  });
}

class InstitutoProfessorsFailureEvent extends InstitutoProfessorsEvent {
  final String message;

  InstitutoProfessorsFailureEvent({required this.message});
}
