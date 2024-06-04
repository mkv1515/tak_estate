import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tak/controllers/auth_controller.dart';
import 'package:tak/controllers/service_request_controller.dart';
import 'package:tak/controllers/visitor_controller.dart';
import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/domain/entities/tenant_house_entity.dart';
import 'package:tak/core/services/secure_storage.dart';
import 'package:tak/core/utils/colors.dart';
import 'package:tak/core/utils/extensions.dart';
import 'package:tak/core/widgets/tak_cache_network_image.dart';
import 'package:tak/features/home/presentation/widgets/carousel_widget.dart';
import 'package:tak/features/home/presentation/widgets/house_banner_widget.dart';
import 'package:tak/features/home/presentation/widgets/service_request_widget.dart';
import 'package:tak/features/home/presentation/widgets/visitors_widget.dart';
import 'package:tak/features/transactions/presentation/widgets/rent_balance_widget.dart';
import 'package:tak/features/transactions/presentation/widgets/service_balance_widget.dart';

import '../../../profile/presentation/pages/profile.dart';
import '../../../service_request/presentation/pages/add_request.dart';
import '../../../settings/presentation/pages/settings.dart';
import '../../../visitors/presentation/pages/add_visitor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SecureStorage secureStorage = SecureStorage();
  String avatar = imageplaceholder;
  String name = "";
  String role = "";
  String status = "";
  String houseId = '';
  TenantHouseEntity? tenantHouseEntity;
  final controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // context.read<AuthBloc>().add(MeEvent());
    setState(() {
      _getUserData();
    });
    //context.read<TransactionBloc>().add(BalanceTransactionFetch());
  }

  _getUserData() async {
    controller.getUserData();
    final controller2 = Get.put(ServiceRequestController());
    controller2.getServiceRequest();
    final controller3 = Get.put(VisitorController());
    controller3.getVisitor();
    name = "${controller.userProfile.value?.name.toString()}".inCaps;
    avatar =
        controller.userProfile.value?.avatar.toString() ?? imageplaceholder;
    role = "${controller.userProfile.value?.role.toString()}".inCaps;
    status = "${controller.userProfile.value?.status.toString()}";
    houseId =
        "${controller.userProfile.value?.tenantHouse?.houseId.toString()}";
    tenantHouseEntity = controller.userProfile.value?.tenantHouse;
  }

  @override
  Widget build(BuildContext context) {
    _getUserData();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //context.push("/settings").then((value) => _getUserData());
              Get.to(() => Settings(
                    userModel: controller.userProfile.value,
                  ));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            //context.push("/profile").then((value) => _getUserData()),
            Get.to(() => Profile(
                  userModel: controller.userProfile.value,
                ));
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: TakCachedNetworkImage(
              // path: controller.userProfile.value?.avatar ?? imageplaceholder,
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
        () => RefreshIndicator(
          onRefresh: _pullRefresh,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Column(
                children: [
                  "${controller.userProfile.value?.status.toString()}" ==
                          "approved"
                      ? Container()
                      : Container(
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
                          child: Text(
                            "Account not yet approved, once approved you will be to do do other things with the app",
                            style: GoogleFonts.robotoFlex(
                              color: white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                  const CarouselWidget(),
                  Gap(16.h),
                  HouseBannerWidget(
                      tenantHouseEntity:
                          controller.userProfile.value?.tenantHouse),
                  Gap(16.h),
                  GestureDetector(
                    onTap: () {
                      //context.push('/rent-transactions')
                    },
                    child: const RentBalanceWidget(),
                  ),
                  Gap(16.h),
                  GestureDetector(
                    onTap: () {
                      //context.push('/service-charge-transactions')
                    },
                    child: const ServiceBalanceWidget(),
                  ),
                  Gap(16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Service Requests",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //context.push('/service-requests')
                          },
                          child: Text(
                            //"See more",
                            "",
                            textAlign: TextAlign.end,
                            style: GoogleFonts.robotoFlex(
                              color: primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Gap(16.h),
                    ],
                  ),
                  Gap(16.h),
                  ServiceRequestWidget(
                      houseId:
                          "${controller.userProfile.value?.tenantHouse?.houseId.toString()}"),
                  Gap(16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Visitors",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //context.push('/visitors')
                          },
                          child: Text(
                            //"See more",
                            "",
                            textAlign: TextAlign.end,
                            style: GoogleFonts.robotoFlex(
                              color: primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Gap(16.h),
                    ],
                  ),
                  Gap(16.h),
                  const VisitorsWidget(),
                  Gap(100.h),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _getFAB(),
    );
  }

  Future<void> _pullRefresh() async {
    _getUserData();
    // context.read<AuthBloc>().add(MeEvent());
    // context.read<ServiceRequestBloc>().add(GetServiceRequestsEvent());
    // context.read<VisitorsBloc>().add(GetVisitorsEvent());
    // context.read<TransactionBloc>().add(BalanceTransactionFetch());
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.sp, color: white),
      backgroundColor: primaryColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.person_pin,
            color: white,
          ),
          backgroundColor: primaryColor,
          onTap: () async {
            //await context.push("/add-visitor");
            // ignore: use_build_context_synchronously
            // context.read<VisitorsBloc>().add(GetVisitorsEvent());
            Get.to(() => const AddVisitor());
          },
          label: 'New Vistor',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: white, fontSize: 16.0.sp),
          labelBackgroundColor: primaryColor,
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.miscellaneous_services_sharp,
            color: white,
          ),
          backgroundColor: primaryColor,
          onTap: () async {
            Get.to(() => AddRequest(
                houseId:
                    "${controller.userProfile.value?.tenantHouse?.houseId.toString()}"));
            //await context.push("/add-request", extra: houseId);
            // ignore: use_build_context_synchronously
            // context.read<ServiceRequestBloc>().add(GetServiceRequestsEvent());
          },
          label: 'Service Request',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: white, fontSize: 16.0.sp),
          labelBackgroundColor: primaryColor,
        )
      ],
    );
  }
}
