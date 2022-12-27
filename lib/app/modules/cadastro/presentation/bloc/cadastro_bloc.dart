import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc_events.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastroBloc extends Bloc {
  CadastroBloc() : super(CadastroEmptyState()) {
    on<SendCadastroEvent>(handleSendCadastroEvent);
    on<ReceivedSuccessCadastroResponseEvent>(
        handleReceivedCadastroResponseEvent);
    on<ReceivedFailureCadastroResponseEvent>(
        handleReceivedFailureCadastroResponseEvent);
  }

  void handleSendCadastroEvent(SendCadastroEvent event, Emitter emit) {
    emit(CadastroLoadingState());
  }

  void handleReceivedCadastroResponseEvent(
      ReceivedSuccessCadastroResponseEvent event, Emitter emit) {
    emit(CadastroSuccessState());
  }

  void handleReceivedFailureCadastroResponseEvent(
      ReceivedFailureCadastroResponseEvent event, Emitter emit) {
    emit(
      CadastroFailureState(message: event.message),
    );
  }
}
