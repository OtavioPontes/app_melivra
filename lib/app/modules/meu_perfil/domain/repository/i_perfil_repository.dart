import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class IPerfilRepository {
  Future<Either<IFailure, void>> update({
    required String name,
    required String email,
  });

  Future<Either<IFailure, void>> delete();
}
