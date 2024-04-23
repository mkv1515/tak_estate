import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';
import 'package:tak/features/profile/domain/entities/profile_entity.dart';
import 'package:tak/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUseCase
    implements UseCase<ProfileEntity, ChangePasswordParams> {
  ProfileRepository repository;

  ChangePasswordUseCase({required this.repository});
  @override
  Future<Either<Failure, ProfileEntity>> call(
      ChangePasswordParams params) async {
    return await repository.changePassword(params);
  }
}

class ChangePasswordParams extends Equatable {
  final String password;

  const ChangePasswordParams({required this.password});

  @override
  List<Object?> get props => [password];
}
