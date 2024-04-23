import 'package:dartz/dartz.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';
import 'package:tak/features/auth/domain/entities/logout_entity.dart';
import 'package:tak/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase extends UseCase<LogoutEntity, void> {
  final AuthRepository repository;

  DeleteAccountUseCase({required this.repository});
  @override
  Future<Either<Failure, LogoutEntity>> call(void params) {
    return repository.deleteAccount();
  }
}
