import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';
import 'package:tak/features/profile/domain/entities/profile_photo_entity.dart';
import 'package:tak/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileImageUseCase
    implements UseCase<ProfilePhototEntity, ProfilePhotoParams> {
  ProfileRepository repository;

  UpdateProfileImageUseCase({required this.repository});
  @override
  Future<Either<Failure, ProfilePhototEntity>> call(
      ProfilePhotoParams params) async {
    return await repository.updatePhoto(params);
  }
}

class ProfilePhotoParams extends Equatable {
  final String path;

  const ProfilePhotoParams({required this.path});
  @override
  List<Object?> get props => [path];
}
