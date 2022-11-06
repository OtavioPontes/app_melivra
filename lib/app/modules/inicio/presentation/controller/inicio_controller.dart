import 'package:app_melivra/app/core/utils/control_state.dart';

class InicioController {
  ControlState state = ControlState.start;

  String failureMessage = '';

  String loadingMessage = '';

  void setLoadingMessage({required String value}) => loadingMessage = value;

  void setStateFailure({
    required String failureMessage,
  }) {
    this.failureMessage = failureMessage;
    state = ControlState.failure();
  }

  Future<void> pipeline() async {
    state = ControlState.loading;
  }
}
