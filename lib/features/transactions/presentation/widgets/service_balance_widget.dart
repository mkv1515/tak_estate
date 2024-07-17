import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/controllers/service_request_controller.dart';
import 'package:tak/core/constants/assets.dart';
import 'package:tak/core/utils/colors.dart';

class ServiceBalanceWidget extends StatelessWidget {
  const ServiceBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceRequestController());

    String? amount = controller.balance.value?.service_Balance.toString();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 8.w, right: 8.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff000000), Color(0xff434343)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Charge Balance",
            style: GoogleFonts.robotoFlex(
              color: white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(8.h),
          Row(
            children: [
              Image.asset(
                withdrawal,
              ),
              Gap(8.w),
              Text(
                "₦ ${amount ?? "0.0"}",
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: GoogleFonts.robotoFlex(
                  color: white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
