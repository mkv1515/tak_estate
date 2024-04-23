import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DescriptionField extends StatelessWidget {
  final Function callback;
  const DescriptionField({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gap(4.h),
          SizedBox(
            width: 358.w,
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (v) {
                callback(v);
              },
              decoration: const InputDecoration(
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
