// ignore_for_file: type_annotate_public_apis

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/network/dio_config.dart';

class SplashPipelineUseCase implements UseCase {
  final INetworkInfo _networkInfo;
  final UserStore _store;
  final DioConfig _dioConfig;

  SplashPipelineUseCase({
    required DioConfig dioConfig,
    required INetworkInfo networkInfo,
    required UserStore store,
  })  : _networkInfo = networkInfo,
        _dioConfig = dioConfig,
        _store = store;

  @override
  Future<Either<IFailure, void>> call(params) async {
    try {
      await _dioConfig.init();

      await _networkInfo.init();

      await _verifyIntenetConnection();

      await Future.delayed(const Duration(seconds: 2));

      if (await _verifyUser()) {
        Modular.to.navigate(BottomNavigationModule.routeName);
        return Right(voidRight);
      }

      Modular.to.navigate(InicioModule.routeName);

      return Right(voidRight);
    } on SettingsFailure catch (e) {
      return Left(e);
    } on UserFailure catch (e) {
      Modular.to.navigate(InicioModule.routeName);
      return Left(e);
    } on InternetConectionFailure catch (e) {
      return Left(e);
    } on TokenFailure {
      await _store.clearUser();
      Modular.to.navigate(InicioModule.routeName);
      return const Left(
        TokenFailure(),
      );
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
    final hasInternetConnection = await _networkInfo.isConnected;

    if (!hasInternetConnection) {
      throw const InternetConectionFailure();
    }
  }

  Future<bool> _verifyUser() async {
    final user = _store.loggedUser;
    if (user != null) {
      final hasExpired = JwtDecoder.isExpired(user.token);
      if (hasExpired) {
        throw const TokenFailure();
      }
      return true;
    }
    return false;
  }
}
