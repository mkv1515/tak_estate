// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tak/controllers/visitor_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/security/domain/entities/security_visitors_entity.dart';

class SecurityVisitorWidget extends StatefulWidget {
  const SecurityVisitorWidget({super.key});

  @override
  State<SecurityVisitorWidget> createState() => _SecurityVisitorWidgetState();
}

class _SecurityVisitorWidgetState extends State<SecurityVisitorWidget> {
  bool _isExpanded = false;
  final controller = Get.put(VisitorController());

  @override
  void initState() {
    setState(() {
      controller.getVisitorSecurity();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.getVisitorSecurity();

    return Obx(() => controller.visitorSecurityList.isEmpty
        ? Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 50.h),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeroIcon(
                  HeroIcons.noSymbol,
                  size: 35.r,
                ),
                Gap(5.h),
                Text(
                  "Expecting no visitors for day!",
                  style: GoogleFonts.robotoFlex(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(20.h),
                ElevatedButton.icon(
                  // <-- ElevatedButton
                  onPressed: () {
                    controller.getVisitorSecurity();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 24.0,
                  ),
                  label: const Text('Refreash'),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: controller.visitorSecurityList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              SecurityVisitorEntity? visitor =
                  controller.visitorSecurityList[index];
              //Logger().d("Check in === ${visitor?.checkIn}");
              return ExpansionTile(
                title: Text(
                  visitor!.visitorName,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                //subtitle: Text(visitor.phone),
                leading: const Icon(Icons.person),
                trailing:
                    Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Arrival",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              convertDate(visitor.arrival),
                              textAlign: TextAlign.end,
                            )),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "House No.",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              visitor.houseNo,
                              textAlign: TextAlign.end,
                            )),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check-In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            visitor.checkIn == null
                                ? Text(
                                    "Pending",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  )
                                : HeroIcon(
                                    HeroIcons.checkBadge,
                                    color: Colors.green[800],
                                  ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check-Out",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            visitor.checkOut == null
                                ? Text(
                                    "Pending",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  )
                                : HeroIcon(
                                    HeroIcons.checkBadge,
                                    color: Colors.green[800],
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  visitor.checkIn == null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 8.w,
                                  right: 8.w,
                                  bottom: 8.h,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: Colors.red,
                                          width: 1.w,
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.red,
                                    ),
                                  ),
                                  child: controller.visitorSecurityList.isNull
                                      ? const TakLoading()
                                      : Text(
                                          "Check-In",
                                          style: GoogleFonts.robotoFlex(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                          ),
                                        ),
                                  onPressed: () {
                                    // context.read<SecurityBloc>().add(
                                    //     CheckInEvent(
                                    //         visitorId:
                                    //             visitor.id.toString()));
                                    controller.checkIn(visitor.id);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const Divider(),
                  visitor.checkOut == null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 8.w,
                                  right: 8.w,
                                  bottom: 8.h,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: Colors.blue,
                                          width: 1.w,
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.blue,
                                    ),
                                  ),
                                  child: controller.visitorSecurityList.isNull
                                      ? const TakLoading()
                                      : Text(
                                          "Check-Out",
                                          style: GoogleFonts.robotoFlex(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                          ),
                                        ),
                                  onPressed: () {
                                    // context.read<SecurityBloc>().add(
                                    //     CheckInEvent(
                                    //         visitorId:
                                    //             visitor.id.toString()));
                                    controller.checkOut(visitor.id);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
                onExpansionChanged: (expanded) =>
                    setState(() => _isExpanded = expanded),
              );
            },
          ));
  }
}
