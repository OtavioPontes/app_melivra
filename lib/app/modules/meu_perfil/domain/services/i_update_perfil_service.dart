import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class IUpdatePerfilService {
  Future<Either<IFailure, void>> call({
    required String name,
    required String email,
  });
}
