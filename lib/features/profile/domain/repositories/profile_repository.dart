import 'package:dartz/dartz.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/features/profile/domain/entities/profile_entity.dart';
import 'package:tak/features/profile/domain/entities/profile_photo_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> updateProfile(params);
  Future<Either<Failure, ProfilePhototEntity>> updatePhoto(params);
  Future<Either<Failure, ProfileEntity>> changePassword(params);
}
