import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/cadastro/data/datasource/i_cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:app_melivra/app/modules/cadastro/domain/services/i_cadastro_service.dart';
import 'package:dartz/dartz.dart';

class CadastroService implements ICadastroService {
  final ICadastroRemoteDatasource _cadastroRemoteDatasource;
  CadastroService({
    required ICadastroRemoteDatasource cadastroRemoteDatasource,
  }) : _cadastroRemoteDatasource = cadastroRemoteDatasource;
  @override
  Future<Either<IFailure, void>> call({required UserCreationModel user}) async {
    try {
      await _cadastroRemoteDatasource.register(
        user: user,
      );
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    }
  }
}
