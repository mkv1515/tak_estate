import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tak/controllers/update_profile_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
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
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateProfileController());
    String password = passwordController.text.toString().trim();

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
              Row(
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
                        Text('Password',
                            style: Theme.of(context).textTheme.titleSmall),
                        Gap(4.h),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          onChanged: (value) {
                            password = value;
                            //Logger().d("real time passwprd === $value");
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? white
                                    : Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? white
                                    : Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
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
              ),
              Gap(16.h),
              ChangePasswordButton(
                password: password.toString(),
                onPressed: () {
                  setState(() {});

                  if (password.length < 8 || password.isEmpty) {
                    toast("Password must be greater than 8 characters");
                    Logger().w("Password must be greater than 8 characters");
                  } else {
                    debugPrint("btn  passwprd === $password");

                    controller.changePassword(password);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
