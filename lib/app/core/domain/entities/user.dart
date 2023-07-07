import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String token;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  List<Object> get props => [name, email, token];

  User copyWith({
    String? userId,
    String? name,
    String? email,
    String? token,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }
}
