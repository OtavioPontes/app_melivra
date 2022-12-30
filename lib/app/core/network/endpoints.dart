class Endpoints {
  /// [AUTH]
  static const String login = '/auth/';

  /// [USER]
  static const String createUser = '/users/';

  /// [INSTITUTOS]
  static const String institutos = '/institutes/';
  static const String institutosRank = '/institutes/ranks';

  /// [PROFESSORES]
  static const String professors = '/professors/';
  static const String professorsRank = '/professors/ranks';
  static String evaluateProfessor({required int id}) =>
      '/professors/$id/grades';
}
