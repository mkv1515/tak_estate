import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tak/features/profile/presentation/widgets/password_field.dart';
import 'package:tak/features/profile/presentation/pages/change_password_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Change Password',
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.keyboard_arrow_left,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16.h),
                PasswordField(passwordController: passwordController),
                Gap(16.h),
                ChangePasswordButton(
                  password: passwordController.text,
                ),
              ],
            ),
          ),
        ),

    );
  }
}
