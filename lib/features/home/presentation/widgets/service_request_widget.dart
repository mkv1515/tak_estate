import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tak/features/home/presentation/widgets/service_request_card.dart';
import 'package:tak/features/service_request/data/models/service_requests_model.dart';

import '../../../../controllers/service_request_controller.dart';

class ServiceRequestWidget extends StatelessWidget {
  final String houseId;
  const ServiceRequestWidget({
    super.key,
    required this.houseId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceRequestController());
    controller.getServiceRequest();
    // return Container();

    RxList<ServiceRequestsModel?> serviceRequests = controller.serviceList;

    if (serviceRequests.isEmpty) {
      return GestureDetector(
        onTap: () {
          // context.push("/add-request", extra: houseId).then((value) {
          //   context
          //       .read<ServiceRequestBloc>()
          //       .add(GetServiceRequestsEvent());
          // });
        },
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey),
          ),
          height: 130.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeroIcon(
                HeroIcons.bell,
                size: 35.r,
              ),
              Gap(5.h),
              Text(
                "Service Requests is Empty",
                style: GoogleFonts.robotoFlex(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 150.dg,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: serviceRequests.length,
            itemBuilder: (context, index) {
              ServiceRequestsModel? request = serviceRequests[index];
              return ServiceRequestCard(request: request);
            }),
      );
    }
  }
}


  // else {
  //   return TakLoading(
  //     color:
  //         Theme.of(context).brightness == Brightness.dark ? white : dark,
  //   );
  // }
