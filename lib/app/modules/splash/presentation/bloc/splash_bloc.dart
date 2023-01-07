import 'package:bloc/bloc.dart';

class SplashBloc extends Bloc {
  SplashBloc() : super(SplashEmptyState()) {
    on<SplashLoadingEvent>(handleSplashLoadingEvent);
    on<SplashSuccessEvent>(handleSplashSuccessEvent);
    on<SplashFailureEvent>(handleSplashFailureEvent);
    on<SplashResetEvent>(handleSplashResetEvent);
  }

  void handleSplashLoadingEvent(SplashLoadingEvent event, Emitter emit) {
    emit(SplashLoadingState());
  }

  void handleSplashSuccessEvent(SplashSuccessEvent event, Emitter emit) {
    emit(
      SplashSuccessState(),
    );
  }

  void handleSplashFailureEvent(SplashFailureEvent event, Emitter emit) {
    emit(SplashFailureState(message: event.message));
  }

  void handleSplashResetEvent(SplashResetEvent event, Emitter emit) {
    emit(SplashEmptyState());
  }
}

abstract class SplashState {}

class SplashEmptyState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashSuccessState extends SplashState {}

class SplashFailureState extends SplashState {
  final String message;

  SplashFailureState({required this.message});
}

abstract class SplashEvent {}

class SplashLoadingEvent extends SplashEvent {}

class SplashSuccessEvent extends SplashEvent {}

class SplashFailureEvent extends SplashEvent {
  final String message;

  SplashFailureEvent({required this.message});
}

class SplashResetEvent extends SplashEvent {}
