import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tak/controllers/notifications_controller.dart';
import 'package:tak/core/constants/assets.dart';
import 'package:tak/core/utils/extensions.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/notification/data/models/notification_model.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    controller.getNotifications();
    List<NotificationModel> notificationEntity = controller.notificationsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
        ),
      ),
      body: Obx(
        () => (controller.notificationsList.isEmpty)
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250.w,
                      height: 250.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(notificationBell),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Gap(16.h),
                    Text(
                      'No Notifications Available',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.all(10.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notificationsList.length,
                  itemBuilder: (context, index) {
                    bool isSameDate = true;
                    final String dateString =
                        notificationEntity[index].created_at;
                    final DateTime date = DateTime.parse(dateString);
                    if (index == 0) {
                      isSameDate = false;
                    } else {
                      final String prevDateString =
                          notificationEntity[index - 1].created_at;
                      final DateTime prevDate = DateTime.parse(prevDateString);
                      isSameDate = date.isSameDate(prevDate);
                    }
                    if (index == 0 || !(isSameDate)) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Gap(8.h),
                            Text(
                              date.formatDate(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Gap(8.h),
                            NotificationCard(
                                notification: notificationEntity[index]),
                          ]);
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Gap(8.h),
                          NotificationCard(
                              notification: notificationEntity[index]),
                        ],
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      margin: EdgeInsets.all(0.w),
      child: Container(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    notification.subject,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    convertDateToAgo(notification.created_at),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            Text(
              notification.message,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
