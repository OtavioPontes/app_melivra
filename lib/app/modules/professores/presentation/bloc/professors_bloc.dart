import 'package:bloc/bloc.dart';

import '../../domain/entities/professor_entity.dart';

class ProfessorsBloc extends Bloc {
  ProfessorsBloc() : super(ProfessorsEmptyState()) {
    on<ProfessorsLoadingEvent>(handleProfessorsLoadingEvent);
    on<ProfessorsSuccessEvent>(handleProfessorsSuccessEvent);
    on<ProfessorsFailureEvent>(handleProfessorsFailureEvent);
  }

  void handleProfessorsLoadingEvent(
      ProfessorsLoadingEvent event, Emitter emit,) {
    emit(ProfessorsLoadingState());
  }

  void handleProfessorsSuccessEvent(
      ProfessorsSuccessEvent event, Emitter emit,) {
    emit(ProfessorsSuccessState(professors: event.professors));
  }

  void handleProfessorsFailureEvent(
      ProfessorsFailureEvent event, Emitter emit,) {
    emit(ProfessorsFailureState(message: event.message));
  }
}

abstract class ProfessorsState {}

class ProfessorsEmptyState extends ProfessorsState {}

class ProfessorsLoadingState extends ProfessorsState {}

class ProfessorsSuccessState extends ProfessorsState {
  final List<Professor> professors;
  ProfessorsSuccessState({
    required this.professors,
  });
}

class ProfessorsFailureState extends ProfessorsState {
  final String message;

  ProfessorsFailureState({required this.message});
}

abstract class ProfessorsEvent {}

class ProfessorsLoadingEvent extends ProfessorsEvent {}

class ProfessorsSuccessEvent extends ProfessorsEvent {
  final List<Professor> professors;
  ProfessorsSuccessEvent({
    required this.professors,
  });
}

class ProfessorsFailureEvent extends ProfessorsEvent {
  final String message;

  ProfessorsFailureEvent({required this.message});
}
