import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';
import 'package:tak/features/profile/domain/entities/profile_entity.dart';
import 'package:tak/features/profile/domain/repositories/profile_repository.dart';


class UpdateProfileUseCase implements UseCase<ProfileEntity, ProfileParams> {
  ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});
  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileParams params) async {
    return await repository.updateProfile(params);
  }
}

class ProfileParams extends Equatable {
  final String name;
  final String gender;
  final String telephone;

  const ProfileParams(
      {required this.name,
      required this.gender,
      required this.telephone});
  @override
  List<Object?> get props => [
        name,
        gender,
        telephone,
      ];
}
