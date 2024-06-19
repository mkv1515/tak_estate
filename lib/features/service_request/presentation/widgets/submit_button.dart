import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/controllers/service_request_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';

class SubmitButton extends StatelessWidget {
  final String? name;
  final String? description;
  final String? priority;
  final String houseId;
  final String? section;
  final List<String> location;
  final List<String> maintenance;

  const SubmitButton({
    super.key,
    required this.name,
    required this.description,
    required this.priority,
    required this.houseId,
    required this.location,
    required this.section,
    required this.maintenance,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceRequestController());
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
        child:
            // state is ServiceRequestLoadingState
            //     ? const TakLoading()
            //     :
            Text(
          "Submit",
          style: GoogleFonts.robotoFlex(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        onPressed: () {
          if (name == null) {
            toast("Name is required");
          } else if (section == null) {
            toast("Select a section");
          } else if (description == null) {
            toast("Description is Required");
          } else if (priority == null) {
            toast("Priority is required");
          } else {
            if (section!.toLowerCase() == "maintenance") {
              if (maintenance.isEmpty) {
                toast("You must select at least one maintenance type");
                return;
              }
              if (location.isEmpty) {
                toast("You must select at least one location");
                return;
              }
            }

// List<String> rooms = ["Sitting Room", "Kitchen"];
//   String jsonString = jsonEncode(rooms);
//   String escapedString = jsonString.replaceAll('"', '\\"');
//   print(escapedString);

            String maintenance1Json = jsonEncode(maintenance);
            String locationStringJson = jsonEncode(location);

            //Logger().d(maintenance1String);

            controller.addServiceRequest(description!, name, priority, houseId,
                section, maintenance1Json, locationStringJson);
            // context.read<ServiceRequestBloc>().add(
            //       AddServiceRequestEvent(
            //         description: description!,
            //         name: name!,
            //         priority: priority!,
            //         houseId: houseId,
            //         section: section!,
            //         maintenance: maintenance,
            //         location: location,
            //       ),
            //     );
          }
        },
      ),
    );
  }
}
