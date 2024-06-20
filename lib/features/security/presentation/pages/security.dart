import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:tak/controllers/auth_controller.dart';
import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/data/models/user_model.dart';
import 'package:tak/core/services/secure_storage.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/extensions.dart';
import 'package:tak/core/widgets/tak_cache_network_image.dart';
import 'package:tak/features/profile/presentation/pages/profile.dart';
import 'package:tak/features/security/presentation/widgets/security_visitor_widget.dart';
import 'package:tak/features/settings/presentation/pages/settings.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  SecureStorage secureStorage = SecureStorage();
  String avatar = imageplaceholder;
  String name = "";
  String role = "";
  String status = "";
  final controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    setState(() {
      _getUserData();
    });
  }

  _getUserData() async {
    // UserModel? usermodel = await secureStorage.getUserData();
    controller.getUserData();

    name = "${controller.userProfile.value?.name.toString()}".inCaps;
    avatar =
        controller.userProfile.value?.avatar.toString() ?? imageplaceholder;
    role = "${controller.userProfile.value?.role.toString()}".inCaps;
    status = "${controller.userProfile.value?.status.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    _getUserData();
    //Logger().d(controller.userProfile.value?.status.toString());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // context.push("/settings").then((value) => _getUserData());

              Get.to(() => Settings(
                    userModel: controller.userProfile.value,
                  ));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            //context.push("/profile").then((value) => _getUserData());

            Get.to(() => Profile(
                  userModel: controller.userProfile.value,
                ));
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: TakCachedNetworkImage(
              path: imageplaceholder,
              width: 20,
              height: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            //context.push("/profile");
          },
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${controller.userProfile.value?.name.toString().inCaps}",
                  style: GoogleFonts.robotoFlex(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${controller.userProfile.value?.role.toString()}".inCaps,
                  style: GoogleFonts.robotoFlex(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              "${controller.userProfile.value?.status.toString()}" != "approved"
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: primaryColor,
                      ),
                      padding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                        bottom: 8.h,
                        top: 8.h,
                      ),
                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: Text(
                        "Account not yet approved, once approved you will be to do do other things with the app",
                        style: GoogleFonts.robotoFlex(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Container(),
              const SecurityVisitorWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
