import 'package:bloc/bloc.dart';

class MeuPerfilBloc extends Bloc {
  MeuPerfilBloc() : super(MeuPerfilEmptyState()) {
    on<MeuPerfilLoadingEvent>(handleMeuPerfilLoadingEvent);
    on<MeuPerfilSuccessEvent>(handleMeuPerfilSuccessEvent);
    on<MeuPerfilFailureEvent>(handleMeuPerfilFailureEvent);
    on<MeuPerfilDeleteEvent>(handleMeuPerfilDeleteEvent);
  }

  void handleMeuPerfilLoadingEvent(MeuPerfilLoadingEvent event, Emitter emit) {
    emit(MeuPerfilLoadingState());
  }

  void handleMeuPerfilSuccessEvent(MeuPerfilSuccessEvent event, Emitter emit) {
    emit(MeuPerfilSuccessState());
  }

  void handleMeuPerfilFailureEvent(MeuPerfilFailureEvent event, Emitter emit) {
    emit(MeuPerfilFailureState(message: event.message));
  }

  void handleMeuPerfilDeleteEvent(MeuPerfilDeleteEvent event, Emitter emit) {
    emit(MeuPerfilDeleteState());
  }
}

abstract class MeuPerfilState {}

class MeuPerfilEmptyState extends MeuPerfilState {}

class MeuPerfilLoadingState extends MeuPerfilState {}

class MeuPerfilSuccessState extends MeuPerfilState {}

class MeuPerfilDeleteState extends MeuPerfilState {}

class MeuPerfilFailureState extends MeuPerfilState {
  final String message;

  MeuPerfilFailureState({required this.message});
}

abstract class MeuPerfilEvent {}

class MeuPerfilLoadingEvent extends MeuPerfilEvent {}

class MeuPerfilSuccessEvent extends MeuPerfilEvent {}

class MeuPerfilDeleteEvent extends MeuPerfilEvent {}

class MeuPerfilFailureEvent extends MeuPerfilEvent {
  final String message;

  MeuPerfilFailureEvent({required this.message});
}
