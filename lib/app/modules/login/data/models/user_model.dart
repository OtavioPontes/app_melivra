import 'dart:convert';

import '../../../../core/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String name,
    required String email,
    required String token,
  }) : super(
          name: name,
          email: email,
          token: token,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? 'Teste',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  User toEntity() {
    return User(
      name: name,
      email: email,
      token: token,
    );
  }

  factory UserModel.fromEntity({required User user}) {
    return UserModel(
      name: user.name,
      email: user.email,
      token: user.token,
    );
  }
}
