import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/get_configuracao_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:version/version.dart';
import 'i_splash_pipeline_usecase.dart';
import 'initializers_usecase.dart';

class SplashPipelineUseCase implements ISplashPipelineUseCase {
  final InitalizersUseCase _initalizersUseCase;
  final INetworkInfo _networkInfo;
  final GetConfiguracaoUseCase _getConfiguracaoUseCase;

  SplashPipelineUseCase({
    required GetConfiguracaoUseCase getConfiguracaoUseCase,
    required InitalizersUseCase initalizersUseCase,
    required INetworkInfo networkInfo,
  })  : _initalizersUseCase = initalizersUseCase,
        _networkInfo = networkInfo,
        _getConfiguracaoUseCase = getConfiguracaoUseCase;

  @override
  Future<Either<IFailure, void>> call(params) async {
    try {
      params.setLoadingMessage('Inicializando o aplicativo');
      await _initalizers();
      params.setLoadingMessage('Verificando conexão com a internet');
      await _verifyIntenetConnection();
      params.setLoadingMessage('Verificando configurações');
      await _verifyConfiguracao(versaoAtual: params.appVersion);
      params.setLoadingMessage('Verificando usuário');

      await Future.delayed(
        const Duration(seconds: 2),
      );

      Modular.to.navigate(InicioModule.initialRoute);

      return Right(voidRight);
    } on SettingsFailure catch (e) {
      // Modular.to.navigate(
      //   SplashModule.routeToForcedUpdate,
      //   arguments: {
      //     'appVersion': e.appVersion,
      //     'versaoMinima': e.minVersion,
      //     'iosAppid': '123456778'
      //   },
      // );
      return Left(e);
    } on UserFailure catch (e) {
      //Modular.to.navigate(AuthWayModule.routeInitial);
      return Left(e);
    } catch (e) {
      //Modular.to.navigate(AuthWayModule.routeInitial);
      return const Left(
        InternalFailure(
          message: 'Houve um problema no pipeline',
        ),
      );
    }
  }

  Future<void> _initalizers() async {
    final failureOrSucess = await _initalizersUseCase(const NoParams());

    return failureOrSucess.fold(
      (failure) => throw failure,
      (sucess) => sucess,
    );
  }

  Future<void> _verifyIntenetConnection() async {
    final bool hasInternetConnection = await _networkInfo.isConnected;

    if (!hasInternetConnection) {
      throw const InternetConectionFailure();
    }
  }

  Future<void> _verifyConfiguracao({
    required String versaoAtual,
  }) async {
    final failureOrSettings = await _getConfiguracaoUseCase(const NoParams());

    return failureOrSettings.fold(
      (failure) => throw failure,
      (settings) {
        final Version appVersion = Version.parse(versaoAtual);
        final Version versaoMinima = Version.parse(settings.versaoMinima);

        if (appVersion < versaoMinima) {
          throw SettingsFailure(
            appVersion: versaoAtual,
            minVersion: settings.versaoMinima,
          );
        }
      },
    );
  }
}
