import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/controllers/auth_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';

class LoginAccountButton extends StatelessWidget {
  final String password;
  final String email;

  const LoginAccountButton({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    // return BlocConsumer<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     if (state is ErrorAuthState) {
    //       toast(state.message);
    //       if (state.message == "unauthenticated") signout(context);
    //     }
    //     if (state is LoginState) {
    //       context.go("/nav");
    //     }
    //   },
    //   builder: (context, state) {
    return Container(
      margin: EdgeInsets.only(
        top: 33.h,
      ),
      width: 358.w,
      height: 52.h,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(
                color: primaryColor,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child:

            //  state is AuthLoadingState
            //     ? const TakLoading()
            //     :

            Obx(
          () => controller.isButtonEnabled.value
              ? Text(
                  "Login",
                  style: GoogleFonts.robotoFlex(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                )
              : const TakLoading(),
        ),
        onPressed: () {
          if (password.length < 8) {
            toast("Password must be greater than 8 characters");
          } else {
            if (email != "" || password != "") {
              controller.loginUser(email, password);
              // context.read<AuthBloc>().add(
              //       LoginEvent(
              //         email: email,
              //         password: password,
              //       ),
              //     );
            } else {
              toast("Provide your email address");
            }
          }
        },
      ),
    );
  }
}
