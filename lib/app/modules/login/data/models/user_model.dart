import 'dart:convert';

import '../../../../core/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String userId,
    required String name,
    required String email,
    required String token,
  }) : super(
          userId: userId,
          name: name,
          email: email,
          token: token,
        );

  Map<String, dynamic> toMap() {
    return {
      'user_id': int.parse(userId),
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'].toString(),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  User toEntity() {
    return User(
      userId: userId,
      name: name,
      email: email,
      token: token,
    );
  }

  factory UserModel.fromEntity({required User user}) {
    return UserModel(
      userId: user.userId,
      name: user.name,
      email: user.email,
      token: user.token,
    );
  }
}
