import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';

abstract class ICadastroRemoteDatasource {
  Future<void> register({required UserCreationModel user});
}
