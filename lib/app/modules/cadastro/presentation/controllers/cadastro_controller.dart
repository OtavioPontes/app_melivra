import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:app_melivra/app/modules/cadastro/domain/usecases/cadastro_user_usecase.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc_events.dart';
import 'package:flutter/cupertino.dart';

class CadastroController {
  final CadastroBloc bloc;
  final CadastroUserUsecase _cadastroUserUsecase;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  CadastroController({
    required this.bloc,
    required CadastroUserUsecase cadastroUserUsecase,
  }) : _cadastroUserUsecase = cadastroUserUsecase;

  Future<void> cadastro() async {
    bloc.add(SendCadastroEvent());
    final result = await _cadastroUserUsecase(
      ParamsCadastroUserUsecase(
        user: UserCreationModel(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text,
        ),
      ),
    );
    result.fold(
      (failure) {
        bloc.add(
            ReceivedFailureCadastroResponseEvent(message: failure.message));
      },
      (success) {
        bloc.add(ReceivedSuccessCadastroResponseEvent());
        clearFields();
      },
    );
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
  }

  bool get isNotEmpty =>
      nameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      passwordConfirmationController.text.isNotEmpty;
}
