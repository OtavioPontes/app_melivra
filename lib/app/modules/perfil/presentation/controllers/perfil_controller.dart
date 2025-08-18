import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/domain/entities/user.dart';

class PerfilController {
  final UserStore _store;
  PerfilController({
    required UserStore store,
  }) : _store = store;

  Future<void> logout() async {
    await _store.clearUser();
    await GoogleSignIn.instance.signOut();
    Modular.to.navigate(InicioModule.routeName);
  }

  User get user => _store.loggedUser!;

  String get nameInitials {
    final nameparts = user.name.split(" ");
    if (nameparts.length > 1) {
      return nameparts[0][0].toUpperCase() + nameparts[1][0].toUpperCase();
    }
    return nameparts[0][0];
  }
}
