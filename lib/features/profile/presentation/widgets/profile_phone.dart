import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tak/core/utils/colors.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneField({
    super.key,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone', style: Theme.of(context).textTheme.titleSmall),
              Gap(4.h),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : Colors.grey,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
