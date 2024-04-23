import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tak/core/error/failure.dart';
import 'package:tak/core/usecases/usecase.dart';
import 'package:tak/features/transactions/domain/entities/transactions_entity.dart';
import 'package:tak/features/transactions/domain/repositories/transaction_repository.dart';

class GetServiceChargeUseCase
    implements UseCase<TransactionsEntity, ServiceChargeParams> {
  final TransactionRepository repository;

  GetServiceChargeUseCase({required this.repository});

  @override
  Future<Either<Failure, TransactionsEntity>> call(params) async {
    return await repository.getServiceCharge(params);
  }
}

class ServiceChargeParams extends Equatable {
  final String startDate;
  final String endDate;

  const ServiceChargeParams({
    required this.startDate,
    required this.endDate,
  });
  @override
  List<Object?> get props => [startDate, endDate];
}
