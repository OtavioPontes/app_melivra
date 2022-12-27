abstract class CadastroEvent {}

class SendCadastroEvent extends CadastroEvent {}

class ReceivedSuccessCadastroResponseEvent extends CadastroEvent {}

class ReceivedFailureCadastroResponseEvent extends CadastroEvent {
  final String message;
  ReceivedFailureCadastroResponseEvent({
    required this.message,
  });
}
