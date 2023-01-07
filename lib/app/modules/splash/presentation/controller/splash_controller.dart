import 'dart:async';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';

import 'package:app_melivra/app/modules/splash/domain/usecases/splash_pipeline_usecase.dart';
import 'package:app_melivra/app/modules/splash/presentation/bloc/splash_bloc.dart';

class SplashController {
  final SplashPipelineUseCase _pipeline;
  final SplashBloc bloc;

  final AppInfo _appInfo;

  SplashController({
    required SplashPipelineUseCase pipeline,
    required AppInfo appInfo,
    required this.bloc,
  })  : _pipeline = pipeline,
        _appInfo = appInfo {
    this.pipeline();
  }

  String appName = '';
  String appVersion = '';

  Future<void> pipeline() async {
    appName = _appInfo.packageInfo.appName;
    appVersion = _appInfo.packageInfo.version;
    bloc.add(
      SplashLoadingEvent(),
    );
    final result = await _pipeline(const NoParams());
    result.fold(
      (failure) => bloc.add(
        SplashFailureEvent(
          message: failure.message,
        ),
      ),
      (succcess) => bloc.add(SplashSuccessEvent()),
    );
  }
}
