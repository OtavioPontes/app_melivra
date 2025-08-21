import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc_events.dart';
import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc_states.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginEmptyState()) {
    on<LoginSubmitEvent>(handleLoginSubmitEvent);
    on<LoginSuccessResponseEvent>(handleLoginSuccessResponseEvent);
    on<LoginFailureResponseEvent>(handleLoginFailureResponseEvent);
  }

  void handleLoginSubmitEvent(LoginSubmitEvent event, Emitter emit) {
    emit(LoginLoadingState());
  }

  void handleLoginSuccessResponseEvent(
    LoginSuccessResponseEvent event,
    Emitter emit,
  ) {
    emit(LoginSuccessState());
  }

  void handleLoginFailureResponseEvent(
    LoginFailureResponseEvent event,
    Emitter emit,
  ) {
    emit(LoginFailureState(message: event.message));
  }
}
