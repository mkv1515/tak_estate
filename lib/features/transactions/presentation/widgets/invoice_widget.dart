import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tak/controllers/service_request_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/core/widgets/tak_error_widget.dart';
import 'package:tak/features/home/presentation/widgets/transaction_widget_debit.dart';
import 'package:tak/features/transactions/domain/entities/invoice_entity.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
            //  List<InvoiceEntity> invoices = [];
    final controller = Get.put(ServiceRequestController());

    return Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Obx(() =>  ListView.builder(
                  itemCount: controller.invoiceList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                              var invoices = controller.invoiceList[index];

                    return TransactionWidgetDebit(
                      invoice: invoices,
                    );
                  },
                ),
              ),


    );
  }
}
