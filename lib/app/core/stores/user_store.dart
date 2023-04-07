import 'package:app_melivra/app/core/bloc/user_bloc.dart';
import 'package:app_melivra/app/core/domain/entities/user.dart';
import 'package:app_melivra/app/modules/login/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserStore {
  final UserBloc bloc;
  final Box _hiveBox;

  User? loggedUser;

  UserStore({
    required Box hiveBox,
    required this.bloc,
    this.loggedUser,
  }) : _hiveBox = hiveBox {
    pipeline();
  }
  Future<void> pipeline() async {
    loggedUser = await getUser();
  }

  Future<User?> getUser() async {
    if (_hiveBox.get('user') != null) {
      final user =
          UserModel.fromMap(Map<String, dynamic>.from(_hiveBox.get('user')))
              .toEntity();
      return user;
    }
    return null;
  }

  Future<void> setUser(User user) async {
    try {
      loggedUser = user;
      await _hiveBox.put(
        'user',
        UserModel.fromEntity(user: user).toMap(),
      );
      bloc.add(UserSuccessEvent());
    } catch (e) {
      bloc.add(
        UserFailureEvent(
          message: 'Falha ao setar usuário',
        ),
      );
    }
  }

  Future<void> clearUser() async {
    loggedUser = null;
    await _hiveBox.delete('user');
  }
}
