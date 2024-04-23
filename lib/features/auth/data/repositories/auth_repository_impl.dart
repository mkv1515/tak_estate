import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tak/core/connection/network_info.dart';
import 'package:tak/core/data/datasources/remote_user_data_source.dart';
import 'package:tak/core/data/models/user_model.dart';
import 'package:tak/core/domain/usecases/updatate_user_fcm_token.dart';
import 'package:tak/core/error/execptions.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/services/secure_storage.dart';
import 'package:tak/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tak/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tak/features/auth/data/models/auth_model.dart';
import 'package:tak/features/auth/data/models/logout_model.dart';
import 'package:tak/features/auth/data/models/email_model.dart';
import 'package:tak/features/auth/data/models/verify_otp_model.dart';
import 'package:tak/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final SecureStorage secureStorage;
  final UserDataSource userDataSource;
  final FirebaseMessaging messaging;
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
    required this.secureStorage,
    required this.userDataSource,
    required this.messaging,
  });

  @override
  Future<Either<Failure, AuthModel>> createAccount({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        AuthModel authModel =
            await remoteDataSource.createAccount(params: params);
        // if status true store Bear token

        secureStorage.saveToken(authModel.token);
        secureStorage.saveAuth(authModel);

        // get data and save to device
        UserModel userModel = await userDataSource.getUserData();
        secureStorage.saveUserData(userModel);
        String? token = await messaging.getToken();
        if (token != null) {
          userDataSource.updateFCMToken(FCMParams(token: token));
        }
        return Right(authModel);
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
  Future<Either<Failure, EmailModel>> email({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        EmailModel emailModel = await remoteDataSource.email(params: params);
        return Right(emailModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauthenticated'));
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server failure!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VerifyOTPModel>> verifyOTP({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        VerifyOTPModel verifyOTPModel =
            await remoteDataSource.verifyOTP(params: params);
        if (verifyOTPModel.message == "Success") {
          // get data and save to device
          UserModel userModel = await userDataSource.getUserData();
          secureStorage.saveUserData(userModel);
          String? token = await messaging.getToken();
          if (token != null) {
            userDataSource.updateFCMToken(FCMParams(token: token));
          }
        }
        return Right(verifyOTPModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauthenticated'));
      } catch (_) {
        return Left(ServerFailure(message: "There is a server failure!"));
      }
    } else {
      return Left(
          NetworkFailure(message: "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        LogoutModel logoutModel = await remoteDataSource.logout();
        // clearAll
        secureStorage.clearAll();
        return Right(logoutModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauthenticated'));
      } catch (_) {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: "Please check your internect connection"));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> login({required params}) async {
    if (await networkInfo.isConnected) {
      try {
        AuthModel authModel = await remoteDataSource.login(params: params);
        // if status true store Bear token

        secureStorage.saveToken(authModel.token);
        secureStorage.saveAuth(authModel);
        // get data and save to device

        UserModel userModel = await userDataSource.getUserData();

        secureStorage.saveUserData(userModel);
        String? token = await messaging.getToken();
        if (token != null) {
          userDataSource.updateFCMToken(FCMParams(token: token));
        }
        return Right(authModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'Email or Password is wrong'));
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> deleteAccount() async {
    if (await networkInfo.isConnected) {
      try {
        LogoutModel logoutModel = await remoteDataSource.deleteAccount();
        // clearAll
        secureStorage.clearAll();
        return Right(logoutModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauthenticated'));
      } catch (_) {
        return Left(ServerFailure(message: "There is a server failure"));
      }
    } else {
      return Left(
          NetworkFailure(message: "Please check your internect connection"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getMe() async {
    if (await networkInfo.isConnected) {
      try {
        UserModel userModel = await userDataSource.getUserData();
        secureStorage.saveUserData(userModel);
        String? token = await messaging.getToken();
        if (token != null) {
          userDataSource.updateFCMToken(FCMParams(token: token));
        }
        return Right(userModel);
      } on UnauthException catch (_) {
        return Left(UnauthFailure(message: 'unauthenticated'));
      } catch (_) {
        return Left(ServerFailure(message: "There is a server failure!"));
      }
    } else {
      return Left(
          NetworkFailure(message: "Please check your internet connection"));
    }
  }
}
