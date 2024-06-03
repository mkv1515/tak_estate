import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:tak/features/transactions/presentation/widgets/invoice_transaction_widget.dart';
import 'package:tak/features/transactions/presentation/widgets/payment_transaction_widget.dart';
import 'package:tak/features/transactions/presentation/widgets/rent_balance_widget.dart';
import 'package:tak/features/transactions/presentation/widgets/service_balance_widget.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String startDate = '';
  String endDate = '';
  @override
  void initState() {
    // context.read<TransactionBloc>()
    //   ..add(TransactionsFetch())
    //   ..add(BalanceTransactionFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rent and Service Transactions',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            GestureDetector(
              onTap: () {
                // context.push('/rent-transactions').then((value) {
                //   context.read<TransactionBloc>()
                //     ..add(TransactionsFetch())
                //     ..add(BalanceTransactionFetch());
                // });
              },
              child: const RentBalanceWidget(),
            ),
            Gap(16.h),
            GestureDetector(
              onTap: () {
                // context.push('/service-charge-transactions').then((value) {
                //   context.read<TransactionBloc>()
                //     ..add(TransactionsFetch())
                //     ..add(BalanceTransactionFetch());
                // });
              },
              child: const ServiceBalanceWidget(),
            ),
            Gap(16.h),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Invoices",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            const InvoiceTransactionWidget(),
            Gap(16.h),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Payments",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const PaymentTransactionWidget(),
            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
