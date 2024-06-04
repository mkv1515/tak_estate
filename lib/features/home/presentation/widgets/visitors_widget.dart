import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';
import 'package:tak/controllers/visitor_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/visitors/data/models/visitors_model.dart';

class VisitorsWidget extends StatefulWidget {
  const VisitorsWidget({super.key});

  @override
  State<VisitorsWidget> createState() => _VisitorsWidgetState();
}

class _VisitorsWidgetState extends State<VisitorsWidget> {
  bool _isExpanded = false;
  final controller = Get.put(VisitorController());

  @override
  void initState() {
    setState(() {
      controller.getVisitor();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.getVisitor();

    RxList<VisitorsModel?> visitorsEntity = controller.visitorList;
    // Logger().w(visitorsEntity);
    if (visitorsEntity.isEmpty) {
      return GestureDetector(
        onTap: () {
          setState(() {
            controller.getVisitor();
          });
          // context.push("/add-visitor").then((value) {
          //   context.read<VisitorsBloc>().add(GetVisitorsEvent());
          // });
        },
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey),
          ),
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    controller.getVisitor();
                  });
                },
                icon: const Icon(Icons.refresh),
              ),
              Gap(5.h),
              Text(
                "Visitors List is Empty, Refreash?",
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
      return ListView.builder(
        itemCount: visitorsEntity.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          VisitorsModel? visitor = visitorsEntity[index];
          return ExpansionTile(
            title: Text(
              visitor!.visitor_name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(visitor.phone),
            leading: const Icon(Icons.person),
            trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
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
                        Text(
                          "Check-In",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
                  ],
                ),
              ),
              //const Divider(),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.only(
              //           left: 8.w,
              //           right: 8.w,
              //           bottom: 8.h,
              //         ),
              //         child: TextButton(
              //             style: ButtonStyle(
              //               shape: MaterialStateProperty.all<
              //                   RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                   side: BorderSide(
              //                     color: primaryColor,
              //                     width: 1.w,
              //                   ),
              //                 ),
              //               ),
              //               backgroundColor: MaterialStateProperty.all<Color>(
              //                 primaryColor,
              //               ),
              //             ),
              //             child: Text(
              //               "Edit",
              //               style: GoogleFonts.robotoFlex(
              //                 fontSize: 12.sp,
              //                 fontWeight: FontWeight.w600,
              //                 color: white,
              //               ),
              //             ),
              //             onPressed: () {
              //               // context.push("/edit-visitor", extra: visitor);
              //             }),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.only(
              //           left: 8.w,
              //           right: 8.w,
              //           bottom: 8.h,
              //         ),
              //         child: TextButton(
              //             style: ButtonStyle(
              //               shape: MaterialStateProperty.all<
              //                   RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                   side: BorderSide(
              //                     color: Colors.red,
              //                     width: 1.w,
              //                   ),
              //                 ),
              //               ),
              //               backgroundColor: MaterialStateProperty.all<Color>(
              //                 Colors.red,
              //               ),
              //             ),
              //             child: visitorsEntity.length < 1
              //                 ? const TakLoading()
              //                 : Text(
              //                     "Delete",
              //                     style: GoogleFonts.robotoFlex(
              //                       fontSize: 12.sp,
              //                       fontWeight: FontWeight.w600,
              //                       color: white,
              //                     ),
              //                   ),
              //             onPressed: () {
              //               //context.push("/edit-visitor", extra: visitor);
              //             }),
              //       ),
              //     ),
              //   ],
              // )
            ],
            onExpansionChanged: (expanded) =>
                setState(() => _isExpanded = expanded),
          );
        },
      );
    }
  }
  //  else {
  //   return TakLoading(
  //     color:
  //         Theme.of(context).brightness == Brightness.dark ? white : dark,
  //   );
  // }
}
