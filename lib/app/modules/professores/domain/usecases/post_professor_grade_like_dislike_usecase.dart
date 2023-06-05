import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/i_professor_repository.dart';

class PostProfessorGradeLikeDislikeUsecase
    implements UseCase<void, ParamsPostProfessorGradeLikeDislikeUsecase> {
  final IProfessorRepository _repository;

  PostProfessorGradeLikeDislikeUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, void>> call(
    ParamsPostProfessorGradeLikeDislikeUsecase params,
  ) async {
    return _repository.evaluateComment(
      isLike: params.isLike,
      id: params.id,
    );
  }
}

class ParamsPostProfessorGradeLikeDislikeUsecase extends IParams {
  final int id;
  final bool isLike;

  ParamsPostProfessorGradeLikeDislikeUsecase({
    required this.id,
    required this.isLike,
  });
}
