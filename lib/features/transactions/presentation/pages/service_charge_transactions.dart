import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:tak/core/services/get_it_services.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:tak/features/transactions/presentation/widgets/invoice_transaction_widget.dart';
import 'package:tak/features/transactions/presentation/widgets/payment_transaction_widget.dart';

class ServiceChargeTransactions extends StatefulWidget {
  const ServiceChargeTransactions({super.key});

  @override
  State<ServiceChargeTransactions> createState() =>
      _ServiceChargeTransactionsState();
}

class _ServiceChargeTransactionsState extends State<ServiceChargeTransactions> {
  String startDate = '';
  String endDate = '';
  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime startDateYear = now.subtract(const Duration(days: 730));
    endDate = DateFormat('yyyy-MM-dd').format(now);
    startDate = DateFormat('yyyy-MM-dd').format(startDateYear);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (context) => getIt<TransactionBloc>()
        ..add(ServiceChargeTransactionFetch(startDate: '', endDate: '')),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Service Charge',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          getDate(context).then((DateTime? value) {
                            if (value != null) {
                              setState(() {
                                startDate =
                                    DateFormat('yyyy-MM-dd').format(value);
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: const Color.fromARGB(255, 184, 180, 180),
                            ),
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            children: [
                              const HeroIcon(HeroIcons.calendar),
                              Gap(8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start Date",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  Text(startDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          getDate(context).then((DateTime? value) {
                            if (value != null) {
                              setState(() {
                                endDate =
                                    DateFormat('yyyy-MM-dd').format(value);
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: const Color.fromARGB(255, 184, 180, 180),
                            ),
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            children: [
                              const HeroIcon(HeroIcons.calendar),
                              Gap(8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "End Date",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  Text(endDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () => context.read<TransactionBloc>().add(
                                ServiceChargeTransactionFetch(
                                  startDate: startDate,
                                  endDate: endDate,
                                ),
                              ),
                          child: Container(
                            height: 65.h,
                            margin: EdgeInsets.only(left: 8.w, right: 8.w),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color: primaryColor,
                              ),
                            ),
                            padding: EdgeInsets.all(8.w),
                            child: const HeroIcon(
                              HeroIcons.funnel,
                              color: white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
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
      ),
    );
  }
}
