import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:dartz/dartz.dart';

abstract class ICadastroService {
  Future<Either<IFailure, void>> call({
    required UserCreationModel user,
  });
  Future<Either<IFailure, void>> sendEmailToValidate({
    required String email,
    required String name,
  });
  Future<Either<IFailure, void>> validateCodeAndEmail({
    required String email,
    required String validationCode,
  });
}
