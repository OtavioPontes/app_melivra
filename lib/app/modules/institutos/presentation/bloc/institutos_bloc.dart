import 'package:bloc/bloc.dart';

import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';

class InstitutosBloc extends Bloc {
  InstitutosBloc() : super(InstitutosEmptyState()) {
    on<InstitutosLoadingEvent>(handleInstitutosLoadingEvent);
    on<InstitutosSuccessEvent>(handleInstitutosSuccessEvent);
    on<InstitutosFailureEvent>(handleInstitutosFailureEvent);
  }

  void handleInstitutosLoadingEvent(
      InstitutosLoadingEvent event, Emitter emit) {
    emit(InstitutosLoadingState());
  }

  void handleInstitutosSuccessEvent(
      InstitutosSuccessEvent event, Emitter emit) {
    emit(InstitutosSuccessState(institutes: event.institutes));
  }

  void handleInstitutosFailureEvent(
      InstitutosFailureEvent event, Emitter emit) {
    emit(InstitutosFailureState(message: event.message));
  }
}

abstract class InstitutosState {}

class InstitutosEmptyState extends InstitutosState {}

class InstitutosLoadingState extends InstitutosState {}

class InstitutosSuccessState extends InstitutosState {
  final List<Instituto> institutes;
  InstitutosSuccessState({
    required this.institutes,
  });
}

class InstitutosFailureState extends InstitutosState {
  final String message;

  InstitutosFailureState({required this.message});
}

abstract class InstitutosEvent {}

class InstitutosLoadingEvent extends InstitutosEvent {}

class InstitutosSuccessEvent extends InstitutosEvent {
  final List<Instituto> institutes;
  InstitutosSuccessEvent({
    required this.institutes,
  });
}

class InstitutosFailureEvent extends InstitutosEvent {
  final String message;

  InstitutosFailureEvent({required this.message});
}
