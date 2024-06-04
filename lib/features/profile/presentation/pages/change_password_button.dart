import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:tak/controllers/update_profile_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';

class ChangePasswordButton extends StatelessWidget {
  final String password;
  final VoidCallback? onPressed;

  const ChangePasswordButton({
    super.key,
    required this.password,
    this.onPressed,
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

              // state is ProfileLoadingState
              //     ? const TakLoading()
              //     :

              Text(
            "Change Password",
            style: GoogleFonts.robotoFlex(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: white,
            ),
          ),
          onPressed: onPressed
          //() async {
          // Logger().i(widget.password);

          // if (state is ProfileLoadingState) {
          // } else {
          //   context.read<ProfileBloc>().add(
          //         ChangePasswordEvent(
          //           password: password,
          //         ),
          //       );
          ),
    );
  }
}
