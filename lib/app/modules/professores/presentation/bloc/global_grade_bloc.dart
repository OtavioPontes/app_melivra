import 'package:bloc/bloc.dart';

import '../../../../core/domain/entities/grade.dart';

class GlobalGradeBloc extends Bloc {
  GlobalGradeBloc() : super(GlobalGradeEmptyState()) {
    on<GlobalGradeLoadingEvent>(handleGlobalGradeLoadingEvent);
    on<GlobalGradeSuccessEvent>(handleGlobalGradeSuccessEvent);
    on<GlobalGradeFailureEvent>(handleGlobalGradeFailureEvent);
  }

  void handleGlobalGradeLoadingEvent(
      GlobalGradeLoadingEvent event, Emitter emit,) {
    emit(GlobalGradeLoadingState());
  }

  void handleGlobalGradeSuccessEvent(
      GlobalGradeSuccessEvent event, Emitter emit,) {
    emit(GlobalGradeSuccessState(grade: event.grade));
  }

  void handleGlobalGradeFailureEvent(
      GlobalGradeFailureEvent event, Emitter emit,) {
    emit(GlobalGradeFailureState(message: event.message));
  }
}

abstract class GlobalGradeState {}

class GlobalGradeEmptyState extends GlobalGradeState {}

class GlobalGradeLoadingState extends GlobalGradeState {}

class GlobalGradeSuccessState extends GlobalGradeState {
  final Grade grade;
  GlobalGradeSuccessState({
    required this.grade,
  });
}

class GlobalGradeFailureState extends GlobalGradeState {
  final String message;

  GlobalGradeFailureState({required this.message});
}

abstract class GlobalGradeEvent {}

class GlobalGradeLoadingEvent extends GlobalGradeEvent {}

class GlobalGradeSuccessEvent extends GlobalGradeEvent {
  final Grade grade;
  GlobalGradeSuccessEvent({
    required this.grade,
  });
}

class GlobalGradeFailureEvent extends GlobalGradeEvent {
  final String message;

  GlobalGradeFailureEvent({required this.message});
}
