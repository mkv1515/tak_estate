import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/extensions.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/transactions/data/model/invoice_model.dart';
import 'package:tak/features/transactions/data/model/payment_model.dart';

class TransactionDetails extends StatefulWidget {
  final Map<String, dynamic> extra;
  const TransactionDetails({super.key, required this.extra});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  InvoiceModel? invoiceEntity;
  PaymentModel? paymentEntity;
  String? type;
  @override
  void initState() {
    type = widget.extra['type'];
    if (widget.extra['type'] == "invoice") {
      invoiceEntity = widget.extra['invoice'];
    } else {
      paymentEntity = widget.extra['payment'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          type == "invoice" ? 'Invoice' : "Payment",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.w),
            child: type == "invoice" ? buildInvoice() : buildPayment()),
      ),
    );
  }

  Widget buildInvoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transaction Details".toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              invoiceEntity!.amount,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              convertDate(invoiceEntity!.created_at),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Invoice No".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              invoiceEntity!.invoice_no,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Type".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              invoiceEntity!.type.inCaps,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Status".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: invoiceEntity!.status == 0 ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                invoiceEntity!.status == 0 ? "pending" : "paid",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transaction Details".toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Amount".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              "${paymentEntity!.amount}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
             convertDate( paymentEntity!.created_at),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            // Text(
            //   convertDateToAgo(paymentEntity!.created_at),
            //   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w600,
            //       ),
            // ),
          ],
        ),
        // Gap(8.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Payment Type".toUpperCase(),
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //     Text(
        //       paymentEntity!.payment_type,
        //       style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //   ],
        // ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Charge".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              "${paymentEntity!.charge}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Status".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: paymentEntity!.status == 0 ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                paymentEntity!.status == 0 ? "pending" : "paid",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
              ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Balance".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              "${paymentEntity!.balance}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Payment Method".toUpperCase(),
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //     Text(
        //       paymentEntity!.payment_method,
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //   ],
        // ),
        //Gap(8.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Prepared By".toUpperCase(),
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //     Text(
        //       paymentEntity!.preparedBy,
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //   ],
        // ),
        // Gap(8.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Currency".toUpperCase(),
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //     Text(
        //       paymentEntity!.currency,
        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //   ],
        // ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Description".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              "${paymentEntity!.description}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Type".toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              paymentEntity!.type,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
