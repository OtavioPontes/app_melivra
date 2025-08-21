class Endpoints {
  /// [AUTH]
  static const String login = '/auth/';

  /// [USER]
  static const String user = '/users/';
  static const String sendValidationCode = '/recoverPassword/';
  static const String validateCode = '/recoverPassword/validate';
  static const String updatePassword = '/users/updatePassword';
  static const String validateEmail = '/validateEmail/';
  static const String validateEmailCode = '/validateEmail/validate';

  /// [INSTITUTOS]
  static const String institutos = '/institutes/';
  static const String institutosRank = '/institutes/ranks';

  /// [PROFESSORES]
  static const String professors = '/professors/';
  static const String professorsRank = '/professors/ranks';
  static String evaluateProfessor({required int id}) =>
      '/professors/$id/grades';
  static String evaluationByProfessorByUser({required int id}) =>
      '/professors/$id/grades/user';
  static String gradesCountbyProfessor({required int id}) =>
      '/professors/$id/grades/count';
  static String evaluateComment({required int gradeId}) =>
      '/grades/$gradeId/likes';

  /// [SUGGESTIONS]
  static const String suggestions = '/suggestions/';

  /// [EXCLUSION REQUEST]
  static String exclusionRequests({required int id}) =>
      '/professors/$id/exclusion-requests';

  /// [GRADES]
  static const String globalGrades = '/grades/global/';
}
