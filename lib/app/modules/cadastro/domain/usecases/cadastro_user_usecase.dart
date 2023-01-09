import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/cadastro/domain/services/i_cadastro_service.dart';

class CadastroUserUsecase implements UseCase<void, ParamsCadastroUserUsecase> {
  final ICadastroService _service;
  CadastroUserUsecase({
    required ICadastroService service,
  }) : _service = service;
  @override
  Future<Either<IFailure, void>> call(params) async {
    try {
      return await _service(user: params.user);
    } catch (_) {
      rethrow;
    }
  }
}

class ParamsCadastroUserUsecase extends IParams {
  final UserCreationModel user;

  ParamsCadastroUserUsecase({
    required this.user,
  });
}
