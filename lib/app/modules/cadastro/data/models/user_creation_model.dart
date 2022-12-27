import 'dart:convert';

class UserCreationModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  UserCreationModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  UserCreationModel copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
  }) {
    return UserCreationModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirm': passwordConfirmation,
    };
  }

  String toJson() => json.encode(toMap());
}
