import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ISplashPipelineUseCase
    implements UseCase<void, ParamsSplashPipeline> {
  @override
  Future<Either<IFailure, void>> call(params);
}

class ParamsSplashPipeline {
  final Function(String) setLoadingMessage;
  final String appVersion;

  ParamsSplashPipeline({
    required this.setLoadingMessage,
    required this.appVersion,
  });
}
