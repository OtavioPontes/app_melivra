import '../models/user_model.dart';

abstract class ILoginDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}
