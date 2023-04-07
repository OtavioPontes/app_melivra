import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:bloc/bloc.dart';

class RankingBloc extends Bloc {
  RankingBloc() : super(RankingEmptyState()) {
    on<RankingLoadingEvent>(handleRankingLoadingEvent);
    on<RankingSuccessEvent>(handleRankingSuccessEvent);
    on<RankingFailureEvent>(handleRankingFailureEvent);
  }

  void handleRankingLoadingEvent(RankingLoadingEvent event, Emitter emit) {
    emit(RankingLoadingState());
  }

  void handleRankingSuccessEvent(RankingSuccessEvent event, Emitter emit) {
    emit(RankingSuccessState(rankInstitutes: event.rankInstitutes));
  }

  void handleRankingFailureEvent(RankingFailureEvent event, Emitter emit) {
    emit(RankingFailureState(message: event.message));
  }
}

abstract class RankingState {}

class RankingEmptyState extends RankingState {}

class RankingLoadingState extends RankingState {}

class RankingSuccessState extends RankingState {
  final List<Instituto> rankInstitutes;
  RankingSuccessState({
    required this.rankInstitutes,
  });
}

class RankingFailureState extends RankingState {
  final String message;

  RankingFailureState({required this.message});
}

abstract class RankingEvent {}

class RankingLoadingEvent extends RankingEvent {}

class RankingSuccessEvent extends RankingEvent {
  final List<Instituto> rankInstitutes;
  RankingSuccessEvent({
    required this.rankInstitutes,
  });
}

class RankingFailureEvent extends RankingEvent {
  final String message;

  RankingFailureEvent({required this.message});
}
