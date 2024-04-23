import 'package:dartz/dartz.dart';
import 'package:tak/core/domain/entities/user_entity.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';
import 'package:tak/features/auth/domain/repositories/auth_repository.dart';

class GetMeUseCase implements UseCase<UserEntity, void> {
  final AuthRepository repository;

  GetMeUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(void params) async {
    return await repository.getMe();
  }
}
