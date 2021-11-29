import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/splash/domain/entities/configuracao_entity.dart';
import 'package:dartz/dartz.dart';

class GetConfiguracaoUseCase implements UseCase<Configuracao, NoParams> {
  @override
  Future<Either<IFailure, Configuracao>> call(params) async {
    return const Right(
      Configuracao(
        versaoMinima: '1.0.0',
        ultimaVersao: '1.0.0',
      ),
    );
    // final failureOrConfiguracao =
    //     await _configuracaoRepository.getConfiguracao();

    // return failureOrConfiguracao.fold(
    //   (failure) => Left(failure),
    //   (configuracao) {
    //     return Right(configuracao);
    //   },
    // );
  }
}
