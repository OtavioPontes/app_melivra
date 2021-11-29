import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/core/utils/control_state.dart';
import 'package:mobx/mobx.dart';
import 'package:pedantic/pedantic.dart';

import '../../domain/usecases/i_splash_pipeline_usecase.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final ISplashPipelineUseCase _pipeline;

  final AppInfo _appInfo;

  _SplashControllerBase({
    required ISplashPipelineUseCase pipeline,
    required AppInfo appInfo,
  })  : _pipeline = pipeline,
        _appInfo = appInfo {
    _init();
  }

  @observable
  ControlState state = ControlState.start;
  @observable
  String failureMessage = '';
  @observable
  String loadingMessage = '';
  @observable
  String appVersion = '';
  @observable
  String appName = '';

  @action
  void _setLoadingMessage({required String value}) => loadingMessage = value;

  @action
  void _setStateFailure({
    required String failureMessage,
  }) {
    this.failureMessage = failureMessage;
    state = ControlState.failure;
  }

  Future<void> _init() async {
    appName = _appInfo.packageInfo.appName;
    unawaited(pipeline());
  }

  Future<void> pipeline() async {
    state = ControlState.loading;
    appVersion = _appInfo.packageInfo.version;
    final failureOrPathToNavigate = await _pipeline(
      ParamsSplashPipeline(
        setLoadingMessage: (message) => _setLoadingMessage(value: message),
        appVersion: appVersion,
      ),
    );

    failureOrPathToNavigate.fold(
      (failure) => _setStateFailure(failureMessage: failure.message),
      (path) => path,
    );
  }
}
