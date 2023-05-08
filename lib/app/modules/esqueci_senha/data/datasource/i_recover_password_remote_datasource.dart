abstract class IRecoverRemoteDatasource {
  Future<void> sendValidationCode({required String email});
  Future<void> validateCode({required String code});
}
