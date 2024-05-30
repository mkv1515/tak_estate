import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/home/presentation/widgets/transaction_widget_credit.dart';
import 'package:tak/features/transactions/domain/entities/payment_entity.dart';
import 'package:tak/features/transactions/domain/entities/transactions_entity.dart';

class PaymentTransactionWidget extends StatelessWidget {
  const PaymentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<PaymentEntity> payments = [];

    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: ListView.builder(
        itemCount: payments.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TransactionWidgetCredit(
            payment: payments[index],
          );
        },
      ),
    );
  }
}
