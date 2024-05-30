import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';

class EmailNextButton extends StatelessWidget {
  final String? email;
  final bool checked;
  final Map<String, dynamic>? otps;
  const EmailNextButton({
    super.key,
    required this.email,
    this.checked = true,
    this.otps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40.h,
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

            Text(
          "Next",
          style: GoogleFonts.robotoFlex(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        onPressed: () {
          if (checked == true) {
            if (email != "") {
              // context.read<AuthBloc>().add(EmailEvent(email: email!));
            } else {
              toast("Provide your email address");
            }
          } else {
            toast("You need to agree to our terms of use");
          }
        },
      ),
    );
  }
}

      // listener
      // listener: (context, state) {
      //   //error
      //   if (state is ErrorAuthState) {
      //     String message = state.message;

      //     toast(message);
      //     if (message == "unauthenticated") signout(context);
      //   }
      //   // register
      //   if (state is EmailState) {
      //     EmailEntity emailEntity = state.emailEntity;
      //     if (emailEntity.status) {
      //       context.push("/create-account", extra: email);
      //     }

      //     toast(emailEntity.message);
      //   }
      // },
