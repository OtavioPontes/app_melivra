import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/send_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/validate_recover_code_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecoverPasswordController {
  final SendRecoverCodeUsecase _sendRecoverCodeUsecase;
  final ValidateRecoverCodeUsecase _validateRecoverCodeUsecase;

  RecoverPasswordController({
    required SendRecoverCodeUsecase sendRecoverCodeUsecase,
    required ValidateRecoverCodeUsecase validateRecoverCodeUsecase,
  })  : _sendRecoverCodeUsecase = sendRecoverCodeUsecase,
        _validateRecoverCodeUsecase = validateRecoverCodeUsecase;

  PageController pageController = PageController();

  String email = '';
  String code = '';

  Future<void> sendRecoverCode() async {
    final result = await _sendRecoverCodeUsecase(
      ParamsSendRecoverCodeUsecase(email: email),
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
      ParamsValidateRecoverCodeUsecase(code: code),
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
}
