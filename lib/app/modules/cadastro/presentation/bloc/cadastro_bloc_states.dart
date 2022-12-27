abstract class CadastroState {}

class CadastroLoadingState extends CadastroState {}

class CadastroEmptyState extends CadastroState {}

class CadastroSuccessState extends CadastroState {}

class CadastroFailureState extends CadastroState {
  final String message;
  CadastroFailureState({
    required this.message,
  });
}
