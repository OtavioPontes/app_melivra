import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/login/domain/usecases/login_usecase.dart';
import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc.dart';
import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc_events.dart';
import 'package:flutter/cupertino.dart';

class LoginController {
  final LoginBloc bloc;
  final UserStore _store;

  final LoginUsecase _loginUsecase;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController({
    required this.bloc,
    required UserStore store,
    required LoginUsecase loginUsecase,
  })  : _loginUsecase = loginUsecase,
        _store = store;

  Future<void> login() async {
    bloc.add(LoginSubmitEvent());
    final result = await _loginUsecase(
      ParamsLoginUsecase(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
    result.fold(
      (failure) =>
          bloc.add(LoginFailureResponseEvent(message: failure.message)),
      (user) {
        _store.setUser(user);
        bloc.add(LoginSuccessResponseEvent());
        clearFields();
      },
    );
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}
