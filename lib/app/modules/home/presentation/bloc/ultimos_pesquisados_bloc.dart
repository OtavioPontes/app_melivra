import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:bloc/bloc.dart';

class UltimosPesquisadosBloc extends Bloc {
  UltimosPesquisadosBloc() : super(UltimosPesquisadosEmptyState()) {
    on<UltimosPesquisadosLoadingEvent>(handleUltimosPesquisadosLoadingEvent);
    on<UltimosPesquisadosSuccessEvent>(handleUltimosPesquisadosSuccessEvent);
    on<UltimosPesquisadosFailureEvent>(handleUltimosPesquisadosFailureEvent);
    on<UltimosPesquisadosEmptyEvent>(handleUltimosPesquisadosEmptyEvent);
  }

  void handleUltimosPesquisadosLoadingEvent(
      UltimosPesquisadosLoadingEvent event, Emitter emit,) {
    emit(UltimosPesquisadosLoadingState());
  }

  void handleUltimosPesquisadosSuccessEvent(
      UltimosPesquisadosSuccessEvent event, Emitter emit,) {
    emit(UltimosPesquisadosSuccessState(professors: event.professors));
  }

  void handleUltimosPesquisadosFailureEvent(
      UltimosPesquisadosFailureEvent event, Emitter emit,) {
    emit(UltimosPesquisadosFailureState(message: event.message));
  }

  void handleUltimosPesquisadosEmptyEvent(
      UltimosPesquisadosEmptyEvent event, Emitter emit,) {
    emit(UltimosPesquisadosEmptyState());
  }
}

abstract class UltimosPesquisadosState {}

class UltimosPesquisadosEmptyState extends UltimosPesquisadosState {}

class UltimosPesquisadosLoadingState extends UltimosPesquisadosState {}

class UltimosPesquisadosSuccessState extends UltimosPesquisadosState {
  final List<Professor> professors;
  UltimosPesquisadosSuccessState({
    required this.professors,
  });
}

class UltimosPesquisadosFailureState extends UltimosPesquisadosState {
  final String message;

  UltimosPesquisadosFailureState({required this.message});
}

abstract class UltimosPesquisadosEvent {}

class UltimosPesquisadosLoadingEvent extends UltimosPesquisadosEvent {}

class UltimosPesquisadosSuccessEvent extends UltimosPesquisadosEvent {
  final List<Professor> professors;
  UltimosPesquisadosSuccessEvent({
    required this.professors,
  });
}

class UltimosPesquisadosFailureEvent extends UltimosPesquisadosEvent {
  final String message;

  UltimosPesquisadosFailureEvent({required this.message});
}

class UltimosPesquisadosEmptyEvent extends UltimosPesquisadosEvent {
  UltimosPesquisadosEmptyEvent();
}
