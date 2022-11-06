import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPipelineUseCase implements UseCase {
  final INetworkInfo _networkInfo;

  SplashPipelineUseCase({
    required INetworkInfo networkInfo,
  }) : _networkInfo = networkInfo;

  @override
  Future<Either<IFailure, void>> call(params) async {
    try {
      await _networkInfo.init();

      await _verifyIntenetConnection();

      await Future.delayed(const Duration(seconds: 2));

      Modular.to.navigate(InicioModule.routeName);

      return Right(voidRight);
    } on SettingsFailure catch (e) {
      return Left(e);
    } on UserFailure catch (e) {
      Modular.to.navigate(InicioModule.routeName);
      return Left(e);
    } catch (e) {
      Modular.to.navigate(InicioModule.routeName);
      return const Left(
        InternalFailure(
          message: 'Houve um problema no pipeline',
        ),
      );
    }
  }

  Future<void> _verifyIntenetConnection() async {
    final bool hasInternetConnection = await _networkInfo.isConnected;

    if (!hasInternetConnection) {
      throw const InternetConectionFailure();
    }
  }
}
