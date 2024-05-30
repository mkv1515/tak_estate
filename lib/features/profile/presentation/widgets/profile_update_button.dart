import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/profile/domain/entities/profile_entity.dart';
import 'package:tak/features/profile/domain/entities/profile_photo_entity.dart';

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
    return Container(
        margin: EdgeInsets.only(
          top: 40.h,
        ),
        width: 358.w,
        height: 52.h,
        child: TextButton(
          onPressed: () {

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
