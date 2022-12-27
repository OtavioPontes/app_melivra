import 'dart:async';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';

import 'package:app_melivra/app/modules/splash/domain/usecases/splash_pipeline_usecase.dart';

class SplashController {
  final SplashPipelineUseCase _pipeline;

  final AppInfo _appInfo;

  SplashController({
    required SplashPipelineUseCase pipeline,
    required AppInfo appInfo,
  })  : _pipeline = pipeline,
        _appInfo = appInfo {
    this.pipeline();
  }

  String failureMessage = '';
  String loadingMessage = '';
  String appName = '';
  String appVersion = '';

  void setLoadingMessage({required String value}) => loadingMessage = value;

  void setStateFailure({
    required String failureMessage,
  }) {
    this.failureMessage = failureMessage;
  }

  Future<void> pipeline() async {
    appName = _appInfo.packageInfo.appName;
    appVersion = _appInfo.packageInfo.version;
    final failureOrPathToNavigate = await _pipeline(const NoParams());

    failureOrPathToNavigate.fold(
      (failure) => setStateFailure(failureMessage: failure.message),
      (path) => path,
    );
  }
}
