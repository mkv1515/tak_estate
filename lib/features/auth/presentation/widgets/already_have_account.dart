import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/features/auth/presentation/pages/login.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 21.h,
      ),
      child: GestureDetector(
        onTap: () {
          //context.push("/login");
          Get.off(() => const Login());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "Login",
              style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
