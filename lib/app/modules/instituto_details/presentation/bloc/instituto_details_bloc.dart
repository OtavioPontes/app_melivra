import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:bloc/bloc.dart';

class InstitutoDetailsBloc extends Bloc {
  InstitutoDetailsBloc() : super(InstitutoDetailsEmptyState()) {
    on<InstitutoDetailsLoadingEvent>(handleInstitutoDetailsLoadingEvent);
    on<InstitutoDetailsSuccessEvent>(handleInstitutoDetailsSuccessEvent);
    on<InstitutoDetailsFailureEvent>(handleInstitutoDetailsFailureEvent);
  }

  void handleInstitutoDetailsLoadingEvent(
      InstitutoDetailsLoadingEvent event, Emitter emit,) {
    emit(InstitutoDetailsLoadingState());
  }

  void handleInstitutoDetailsSuccessEvent(
      InstitutoDetailsSuccessEvent event, Emitter emit,) {
    emit(InstitutoDetailsSuccessState(institute: event.institute));
  }

  void handleInstitutoDetailsFailureEvent(
      InstitutoDetailsFailureEvent event, Emitter emit,) {
    emit(InstitutoDetailsFailureState(message: event.message));
  }
}

abstract class InstitutoDetailsState {}

class InstitutoDetailsEmptyState extends InstitutoDetailsState {}

class InstitutoDetailsLoadingState extends InstitutoDetailsState {}

class InstitutoDetailsSuccessState extends InstitutoDetailsState {
  final Instituto institute;
  InstitutoDetailsSuccessState({
    required this.institute,
  });
}

class InstitutoDetailsFailureState extends InstitutoDetailsState {
  final String message;

  InstitutoDetailsFailureState({required this.message});
}

abstract class InstitutoDetailsEvent {}

class InstitutoDetailsLoadingEvent extends InstitutoDetailsEvent {}

class InstitutoDetailsSuccessEvent extends InstitutoDetailsEvent {
  final Instituto institute;
  InstitutoDetailsSuccessEvent({
    required this.institute,
  });
}

class InstitutoDetailsFailureEvent extends InstitutoDetailsEvent {
  final String message;

  InstitutoDetailsFailureEvent({required this.message});
}
