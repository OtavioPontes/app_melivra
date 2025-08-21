import 'package:app_melivra/app/modules/cadastro/domain/services/i_cadastro_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidateEmailController
    extends Bloc<ValidateEmailEvent, ValidateEmailState> {
  final ICadastroService _cadastroService;

  ValidateEmailController({
    required ICadastroService cadastroService,
  })  : _cadastroService = cadastroService,
        super(ValidateEmailEmptyState()) {
    on<SendValidationCodeEvent>(onValidateEmailSubmitted);
    on<ValidateEmailPinCodeEnteredEvent>(
      onValidateEmailPinCodeEntered,
    );
  }

  String pinCode = '';

  Future<void> onValidateEmailSubmitted(
    SendValidationCodeEvent event,
    Emitter emit,
  ) async {
    emit(ValidateEmailLoadingState());
    final result = await _cadastroService.sendEmailToValidate(
      email: event.email,
      name: event.name,
    );
    result.fold(
      (failure) {
        emit(ValidateEmailFailureState(message: failure.message));
      },
      (success) {
        emit(ValidateEmailSuccessState());
      },
    );
  }

  Future<void> onValidateEmailPinCodeEntered(
    ValidateEmailPinCodeEnteredEvent event,
    Emitter emit,
  ) async {
    emit(ValidateEmailCodeLoadingState());

    final result = await _cadastroService.validateCodeAndEmail(
      email: event.email,
      validationCode: event.pinCode,
    );
    result.fold(
      (failure) {
        emit(ValidateEmailCodeFailureState(message: failure.message));
      },
      (success) {
        emit(ValidateEmailCodeSuccessState());
      },
    );
  }
}

abstract class ValidateEmailState {}

class ValidateEmailEmptyState extends ValidateEmailState {}

class ValidateEmailLoadingState extends ValidateEmailState {}

class ValidateEmailSuccessState extends ValidateEmailState {}

class ValidateEmailFailureState extends ValidateEmailState {
  final String message;
  ValidateEmailFailureState({
    required this.message,
  });
}

class ValidateEmailCodeSuccessState extends ValidateEmailState {}

class ValidateEmailCodeFailureState extends ValidateEmailState {
  final String message;
  ValidateEmailCodeFailureState({
    required this.message,
  });
}

class ValidateEmailCodeLoadingState extends ValidateEmailState {}

abstract class ValidateEmailEvent {}

class SendValidationCodeEvent extends ValidateEmailEvent {
  final String email;
  final String name;
  SendValidationCodeEvent({
    required this.email,
    required this.name,
  });
}

class ValidateEmailPinCodeEnteredEvent extends ValidateEmailEvent {
  final String email;
  final String pinCode;
  ValidateEmailPinCodeEnteredEvent({
    required this.email,
    required this.pinCode,
  });
}
