import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';

abstract class ICadastroRemoteDatasource {
  Future<void> register({required UserCreationModel user});
  Future<void> sendEmailToValidate({
    required String email,
    required String name,
  });
  Future<void> validateCodeAndEmail({
    required String email,
    required String validationCode,
  });
}
