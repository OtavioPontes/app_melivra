import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

class InitalizersUseCase implements UseCase<bool, NoParams> {
  final INetworkInfo _networkInfo;

  InitalizersUseCase({
    required INetworkInfo networkInfo,
  }) : _networkInfo = networkInfo;

  @override
  Future<Either<IFailure, bool>> call(params) async {
    try {
      await _networkInfo.init();

      return const Right(true);
    } catch (e) {
      return const Left(
        Failure(
          message: 'Falha ao inicializar o aplicativo',
        ),
      );
    }
  }
}
