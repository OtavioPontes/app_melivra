abstract class IRecoverRemoteDatasource {
  Future<void> sendValidationCode({required String email});
  Future<void> validateCode({required String code, required String email});
  Future<void> updatePassword({
    required String code,
    required String email,
    required String password,
    required String passwordConfirm,
  });
}
