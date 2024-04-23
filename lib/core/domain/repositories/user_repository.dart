import 'package:dartz/dartz.dart';
import 'package:tak/core/domain/entities/fcm_entity.dart';
import 'package:tak/core/domain/entities/user_entity.dart';
import 'package:tak/core/domain/usecases/updatate_user_fcm_token.dart';
import 'package:tak/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> fetchUserData();
  Future<Either<Failure, FCMEntity>> updateFCMToken(FCMParams params);
}
