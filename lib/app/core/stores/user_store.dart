import 'package:hive_flutter/hive_flutter.dart';

import 'package:app_melivra/app/core/domain/entities/user.dart';
import 'package:app_melivra/app/modules/login/data/models/user_model.dart';

class UserStore {
  final Box _hiveBox;

  User? loggedUser;

  UserStore({
    required Box hiveBox,
    this.loggedUser,
  }) : _hiveBox = hiveBox {
    pipeline();
  }
  pipeline() async {
    loggedUser = await getUser();
  }

  Future<User?> getUser() async {
    if (_hiveBox.get('user') != null) {
      User user =
          UserModel.fromMap(Map<String, dynamic>.from(_hiveBox.get('user')))
              .toEntity();
      return user;
    }
    return null;
  }

  Future<void> setUser(User user) async {
    loggedUser = user;
    await _hiveBox.put(
      'user',
      UserModel.fromEntity(user: user).toMap(),
    );
  }

  Future<void> clearUser() async {
    loggedUser = null;
    await _hiveBox.delete('user');
  }
}
