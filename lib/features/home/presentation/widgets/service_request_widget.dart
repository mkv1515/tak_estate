import 'package:flutter/material.dart';

class ServiceRequestWidget extends StatelessWidget {
  final String houseId;
  const ServiceRequestWidget({
    super.key,
    required this.houseId,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
    // return BlocBuilder<ServiceRequestBloc, ServiceRequestState>(
    //   buildWhen: (pre, state) {
    //     return state is ServiceRequestLoadingState ||
    //         state is ServiceRequestsLoadedState ||
    //         state is ServiceRequestErrorState;
    //   },
    //   builder: (context, state) {
    //     if (state is ServiceRequestLoadingState) {
    //       return TakLoading(
    //         color:
    //             Theme.of(context).brightness == Brightness.dark ? white : dark,
    //       );
    //     } else if (state is ServiceRequestErrorState) {
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             const Text(
    //               "Reload again",
    //               style: TextStyle(
    //                 color: Colors.red,
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () => context
    //                   .read<ServiceRequestBloc>()
    //                   .add(GetServiceRequestsEvent()),
    //               icon: const Icon(Icons.refresh),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else if (state is ServiceRequestsLoadedState) {
    //       List<ServiceRequestsEntity> serviceRequests = state.servicesRequests;

    //       if (serviceRequests.isEmpty) {
    //         return GestureDetector(
    //           onTap: () {
    //             context.push("/add-request", extra: houseId).then((value) {
    //               context
    //                   .read<ServiceRequestBloc>()
    //                   .add(GetServiceRequestsEvent());
    //             });
    //           },
    //           child: Container(
    //             margin: EdgeInsets.only(left: 14.w, right: 14.w),
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.r),
    //               border: Border.all(color: Colors.grey),
    //             ),
    //             height: 120.h,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 HeroIcon(
    //                   HeroIcons.plus,
    //                   size: 35.r,
    //                 ),
    //                 Gap(5.h),
    //                 Text(
    //                   "Create New",
    //                   style: GoogleFonts.robotoFlex(
    //                     fontSize: 15.sp,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       } else {
    //         return SizedBox(
    //           height: 120.h,
    //           child: ListView.builder(
    //               scrollDirection: Axis.horizontal,
    //               shrinkWrap: true,
    //               itemCount: serviceRequests.length,
    //               itemBuilder: (context, index) {
    //                 ServiceRequestsEntity request = serviceRequests[index];
    //                 return ServiceRequestCard(request: request);
    //               }),
    //         );
    //       }
    //     } else {
    //       return TakLoading(
    //         color:
    //             Theme.of(context).brightness == Brightness.dark ? white : dark,
    //       );
    //     }
    //   },
    // );
  }
}
