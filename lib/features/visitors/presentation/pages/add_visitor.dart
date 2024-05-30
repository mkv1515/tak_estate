import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tak/features/visitors/presentation/widgets/date_arrival.dart';
import 'package:tak/features/visitors/presentation/widgets/phone_field.dart';
import 'package:tak/features/visitors/presentation/widgets/submit_button.dart';
import 'package:tak/features/visitors/presentation/widgets/visitor_name_field.dart';

class AddVisitor extends StatefulWidget {
  const AddVisitor({super.key});

  @override
  State<AddVisitor> createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor> {
  String? visitorName;
  String? visitorPhoneNumber;
  String? carRegNo;
  String? reason;
  String? destination;
  String? arrival;
  String? departure;

  @override
  void initState() {
    DateTime now = DateTime.now();
    DateFormat formatterspan = DateFormat('yyyy-MM-dd');
    String datespan = formatterspan.format(now);
    DateFormat formattertime = DateFormat('hh:mm:ss');
    String timespan = formattertime.format(now);

    arrival = "$datespan $timespan";
    departure = "$datespan $timespan";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text(
            'New Visitor',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Column(
              children: [
                VisitorNameField(callback: (v) {
                  setState(() {
                    visitorName = v;
                  });
                }),
                Gap(16.h),
                PhoneField(callback: (v) {
                  setState(() {
                    visitorPhoneNumber = v;
                  });
                }),
                Gap(16.h),
                DateArrival(
                  callback: (v) {
                    setState(() {
                      arrival = v;
                    });
                  },
                ),
                Gap(16.h),
                SubmitButton(
                  visitorName: visitorName,
                  visitorPhoneNumber: visitorPhoneNumber,
                  arrival: arrival,
                  departure: departure,
                ),
                Gap(16.h),
              ],
            ),
          ),
        ),
      
    );
  }
}
