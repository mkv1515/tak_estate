import 'package:dartz/dartz.dart';
import 'package:tak/core/connection/network_info.dart';
import 'package:tak/core/data/datasources/remote_user_data_source.dart';
import 'package:tak/core/data/models/fcm_model.dart';
import 'package:tak/core/data/models/user_model.dart';
import 'package:tak/core/domain/repositories/user_repository.dart';
import 'package:tak/core/domain/usecases/updatate_user_fcm_token.dart';
import 'package:tak/core/error/execptions.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/services/secure_storage.dart';

class UserRepositoryImpl implements UserRepository {
  UserDataSource remoteDataSource;
  NetworkInfo networkInfo;
  SecureStorage secureStorage;

  UserRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.secureStorage});
  @override
  Future<Either<Failure, UserModel>> fetchUserData() async {
    if (await networkInfo.isConnected) {
      try {
        // get data and save to device
        UserModel userModel = await remoteDataSource.getUserData();
        secureStorage.saveUserData(userModel);
        return Right(userModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauthenticated'));
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FCMModel>> updateFCMToken(FCMParams params) async {
    if (await networkInfo.isConnected) {
      try {
        FCMModel fcmModel = await remoteDataSource.updateFCMToken(params);
        return Right(fcmModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauth'));
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}
