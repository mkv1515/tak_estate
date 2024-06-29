import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tak/controllers/service_request_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/home/presentation/widgets/transaction_widget_credit.dart';
import 'package:tak/features/transactions/domain/entities/payment_entity.dart';
import 'package:tak/features/transactions/domain/entities/transactions_entity.dart';

class PaymentTransactionWidget extends StatelessWidget {
  const PaymentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceRequestController());

    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Obx(() =>  ListView.builder(
          itemCount: controller.paymentList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var payments = controller.paymentList[index];

            return TransactionWidgetCredit(
              payment: payments,
            );
          },
        ),
      ),
    );
  }
}
