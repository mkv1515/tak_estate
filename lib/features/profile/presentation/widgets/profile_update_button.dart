import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:tak/controllers/update_profile_controller.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';

class UpdateProfileButton extends StatelessWidget {
  final String name;
  final String gender;
  final String phone;

  const UpdateProfileButton({
    super.key,
    required this.name,
    required this.gender,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateProfileController());
    return Container(
        margin: EdgeInsets.only(
          top: 40.h,
        ),
        width: 358.w,
        height: 52.h,
        child: TextButton(
          onPressed: () {
            if (gender.isNotEmpty) {
              Logger().i("$name, $phone, $gender");
              controller.updateProfile(phone, gender, name);
            } else {
              toast('Please select a gender');
            }
          },
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
            "Update Profile",
            style: GoogleFonts.robotoFlex(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: white,
            ),
          ),
          // onPressed: () async {
          //   if (state is ProfileLoadingState) {
          //   } else {
          //     context.read<ProfileBloc>().add(
          //           ProfileUpdateEvent(
          //             name: name,
          //             gender: gender,
          //             telephone: phone,
          //           ),
          //         );
        ));
  }
}
