import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/send_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/update_password_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/validate_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/home/home_module.dart';
import 'package:app_melivra/app/modules/login/login_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecoverPasswordController {
  final SendRecoverCodeUsecase _sendRecoverCodeUsecase;
  final ValidateRecoverCodeUsecase _validateRecoverCodeUsecase;
  final UpdatePasswordUsecase _updatePasswordUsecase;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  RecoverPasswordController({
    required UpdatePasswordUsecase updatePasswordUsecase,
    required SendRecoverCodeUsecase sendRecoverCodeUsecase,
    required ValidateRecoverCodeUsecase validateRecoverCodeUsecase,
  })  : _sendRecoverCodeUsecase = sendRecoverCodeUsecase,
        _updatePasswordUsecase = updatePasswordUsecase,
        _validateRecoverCodeUsecase = validateRecoverCodeUsecase;

  PageController pageController = PageController();

  String email = '';
  String code = '';
  String password = '';
  String passwordConfirmation = '';

  Future<void> sendRecoverCode() async {
    final result = await _sendRecoverCodeUsecase(
      ParamsSendRecoverCodeUsecase(email: email.trim()),
    );

    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: failure.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 15,
        );
      },
      (success) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
        Fluttertoast.showToast(
          msg: "Código enviado com sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 15,
        );
      },
    );
  }

  Future<void> validateRecoverCode() async {
    final result = await _validateRecoverCodeUsecase(
      ParamsValidateRecoverCodeUsecase(code: code, email: email),
    );

    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: failure.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 15,
        );
      },
      (success) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      },
    );
  }

  Future<void> updatePassword() async {
    final result = await _updatePasswordUsecase(
      ParamsUpdatePasswordUsecase(
        code: code,
        email: email.trim(),
        password: password.trim(),
        passwordConfirm: passwordConfirmation.trim(),
      ),
    );

    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: failure.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 15,
        );
      },
      (success) {
        Fluttertoast.showToast(
          msg: "Senha trocada com Sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 15,
        );
        Modular.to.navigate(HomeModule.routeName);
        Modular.to.pushNamed(LoginModule.routeName);
      },
    );
  }
}
