class InicioController {
  String failureMessage = '';

  String loadingMessage = '';

  void setLoadingMessage({required String value}) => loadingMessage = value;

  void setStateFailure({
    required String failureMessage,
  }) {
    this.failureMessage = failureMessage;
  }

  Future<void> pipeline() async {}
}
