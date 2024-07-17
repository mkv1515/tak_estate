import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:tak/controllers/add_visitor_controller.dart';
import 'package:tak/controllers/visitor_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';

class SubmitButton extends StatelessWidget {
  final String? visitorPhoneNumber;
  final String? visitorName;
  final String? arrival;
  final String? departure;
  final String? reason;

  const SubmitButton({
    super.key,
    required this.visitorPhoneNumber,
    required this.visitorName,
    required this.arrival,
    required this.departure,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddVisitorController());
    Logger().d("submitting === ${controller.submitting.value}");
    return Container(
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: primaryColor,
                width: 1.w,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child: Obx(
          () => controller.submitting.value == true
              ? Text(
                  "Submit",
                  style: GoogleFonts.robotoFlex(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                )
              : const TakLoading(),
        ),
        onPressed: () {
          // Logger().i(
          //     "$visitorName, $visitorPhoneNumber, $reason, $arrival, $departure");

          if (visitorName!.isEmpty) {
            toast("Visitor Name is required");
          }

          //  else if (visitorPhoneNumber!.isEmpty) {
          //   toast("Visitor Phone number is required");
          // } else if (reason!.isEmpty) {
          //   toast("Reason for visit is required");
          // }

          else if (arrival!.isEmpty) {
            toast("Arrival Date is required");
          } else if (departure!.isEmpty) {
            toast("Departure Date is required");
          } else {
            controller.addVistor(
                visitorName!, visitorPhoneNumber, reason, arrival, departure);
            // context.read<VisitorsBloc>().add(AddVisitorEvent(
            //       phone: visitorPhoneNumber!,
            //       arrival: arrival!,
            //       departure: departure!,
            //       carRegno: '',
            //       reason: '',
            //       destination: '',
            //       visitorName: visitorName!,
            //     ));
          }
        },
      ),
    );
  }
}
