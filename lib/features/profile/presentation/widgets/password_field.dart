import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tak/core/utils/colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordField({
    super.key,
    required this.passwordController,
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
              Text('Password', style: Theme.of(context).textTheme.titleSmall),
              Gap(4.h),
              TextFormField(
                obscureText: true,
                controller: passwordController,
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
