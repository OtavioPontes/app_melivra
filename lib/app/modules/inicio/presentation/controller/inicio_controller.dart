import 'package:app_melivra/app/core/utils/control_state.dart';
import 'package:mobx/mobx.dart';

part 'inicio_controller.g.dart';

class InicioController = _InicioControllerBase with _$InicioController;

abstract class _InicioControllerBase with Store {
  @observable
  ControlState state = ControlState.start;
  @observable
  String failureMessage = '';
  @observable
  String loadingMessage = '';

  @action
  void _setLoadingMessage({required String value}) => loadingMessage = value;

  @action
  void _setStateFailure({
    required String failureMessage,
  }) {
    this.failureMessage = failureMessage;
    state = ControlState.failure;
  }

  Future<void> pipeline() async {
    state = ControlState.loading;
  }
}
