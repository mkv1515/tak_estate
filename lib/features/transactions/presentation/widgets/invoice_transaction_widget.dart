import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/home/presentation/widgets/transaction_widget_debit.dart';
import 'package:tak/features/transactions/domain/entities/invoice_entity.dart';
import 'package:tak/features/transactions/domain/entities/transactions_entity.dart';

class InvoiceTransactionWidget extends StatelessWidget {
  const InvoiceTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //TransactionsEntity transactionsEntity = state.transactionsEntity;

    List<InvoiceEntity> invoices = [];
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: ListView.builder(
        itemCount: invoices.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TransactionWidgetDebit(
            invoice: invoices[index],
          );
        },
      ),
    );
  }
}
        //  if (false == false) {
        //   return Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         const Text(
        //           "Reload again",
        //           style: TextStyle(
        //             color: Colors.red,
        //           ),
        //         ),
        //         IconButton(
        //           onPressed: () {
        //              // context.read<TransactionBloc>().add(TransactionsFetch()),
        //           },
        //           icon: const Icon(Icons.refresh),
        //         ),
        //       ],
        //     ),
