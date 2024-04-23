import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_along_loading.dart';
import 'package:tak/features/profile/presentation/bloc/profile_bloc.dart';

class ChangePasswordButton extends StatelessWidget {
  final String password;
  const ChangePasswordButton({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is ProfileErrorState) {
        toast(state.message);
        if (state.message == "unauthenticated") signout(context);
      }
      if (state is ProfileUpdateState) {
        toast(state.profileEntity.message);
      }
    }, builder: (context, state) {
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
          child: state is ProfileLoadingState
              ? const TakLoading()
              : Text(
                  "Change Password",
                  style: GoogleFonts.robotoFlex(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                ),
          onPressed: () async {
            if (state is ProfileLoadingState) {
            } else {
              context.read<ProfileBloc>().add(
                    ChangePasswordEvent(
                      password: password,
                    ),
                  );
            }
          },
        ),
      );
    });
  }
}