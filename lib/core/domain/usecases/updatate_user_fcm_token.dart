import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tak/core/domain/entities/fcm_entity.dart';
import 'package:tak/core/domain/repositories/user_repository.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';

class UpdateUserFCMTokenUseCase implements UseCase<FCMEntity, FCMParams> {
  UserRepository repository;
  UpdateUserFCMTokenUseCase({required this.repository});
  @override
  Future<Either<Failure, FCMEntity>> call(FCMParams params) async {
    return await repository.updateFCMToken(params);
  }
}

class FCMParams extends Equatable {
  final String token;

  const FCMParams({required this.token});

  @override
  List<Object?> get props => [token];
}
