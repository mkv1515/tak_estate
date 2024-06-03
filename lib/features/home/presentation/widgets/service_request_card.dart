import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/features/service_request/data/models/service_requests_model.dart';

class ServiceRequestCard extends StatelessWidget {
  final ServiceRequestsModel? request;

  const ServiceRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      //height: 300.h,
      margin: EdgeInsets.only(right: 15.w, left: 10.w, top: 5.h, bottom: 5.h),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              maxLines: 1,
              request!.description,
              style: GoogleFonts.robotoFlex(
                color: white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Text(
                  "Status: ",
                  style: GoogleFonts.robotoFlex(
                    color: white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  request!.status,
                  style: GoogleFonts.robotoFlex(
                    color: white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Text(
                  "Priority: ",
                  style: GoogleFonts.robotoFlex(
                    color: white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  size: 24.dg,
                  _getIconForPriority(request!.priority),
                  color: _getColorForPriority(request!.priority),
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              maxLines: 1,
              "Last Updated: ${request!.created_at}",

              // "Last Updated: ${convertDateToAgo(request!.created_at)}",
              style: GoogleFonts.robotoFlex(
                color: white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getIconForPriority(priority) {
    switch (priority) {
      case "Low":
        return Icons.star_border;
      case "Medium":
        return Icons.star_half;
      case "High":
        return Icons.star;
      default:
        return Icons.star_border;
    }
  }

  Color _getColorForPriority(priority) {
    switch (priority) {
      case "Low":
        return Colors.grey;
      case "Medium":
        return Colors.orange;
      case "High":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
