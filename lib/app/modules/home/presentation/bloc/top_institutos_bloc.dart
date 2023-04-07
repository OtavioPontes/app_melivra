import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:bloc/bloc.dart';

class TopInstitutosBloc extends Bloc {
  TopInstitutosBloc() : super(TopInstitutosEmptyState()) {
    on<TopInstitutosLoadingEvent>(handleTopInstitutosLoadingEvent);
    on<TopInstitutosSuccessEvent>(handleTopInstitutosSuccessEvent);
    on<TopInstitutosFailureEvent>(handleTopInstitutosFailureEvent);
  }

  void handleTopInstitutosLoadingEvent(
      TopInstitutosLoadingEvent event, Emitter emit,) {
    emit(TopInstitutosLoadingState());
  }

  void handleTopInstitutosSuccessEvent(
      TopInstitutosSuccessEvent event, Emitter emit,) {
    emit(TopInstitutosSuccessState(rankInstitutes: event.rankInstitutes));
  }

  void handleTopInstitutosFailureEvent(
      TopInstitutosFailureEvent event, Emitter emit,) {
    emit(TopInstitutosFailureState(message: event.message));
  }
}

abstract class TopInstitutosState {}

class TopInstitutosEmptyState extends TopInstitutosState {}

class TopInstitutosLoadingState extends TopInstitutosState {}

class TopInstitutosSuccessState extends TopInstitutosState {
  final List<Instituto> rankInstitutes;
  TopInstitutosSuccessState({
    required this.rankInstitutes,
  });
}

class TopInstitutosFailureState extends TopInstitutosState {
  final String message;

  TopInstitutosFailureState({required this.message});
}

abstract class TopInstitutosEvent {}

class TopInstitutosLoadingEvent extends TopInstitutosEvent {}

class TopInstitutosSuccessEvent extends TopInstitutosEvent {
  final List<Instituto> rankInstitutes;
  TopInstitutosSuccessEvent({
    required this.rankInstitutes,
  });
}

class TopInstitutosFailureEvent extends TopInstitutosEvent {
  final String message;

  TopInstitutosFailureEvent({required this.message});
}
