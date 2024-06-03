import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tak/controllers/messages_controller.dart';
import 'package:tak/core/constants/assets.dart';
import 'package:tak/core/utils/extensions.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/messages/data/models/message_model.dart';
import 'package:tak/features/messages/domain/entities/messages_entity.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessagesController());
    controller.getMessages();
    List<MessageModel> messageEntity = controller.messageList;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Messages',
          ),
        ),
        body: (controller.messageList.isEmpty)
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
                          image: AssetImage(messageGif),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Gap(16.h),
                    Text(
                      'No Messages Available',
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
                  itemCount: controller.messageList.length,
                  itemBuilder: (context, index) {
                    final data = controller.messageList[index];
                    bool isSameDate = true;
                    final String? dateString = messageEntity[index].createdAt;
                    final DateTime date = DateTime.parse(dateString!);
                    if (index == 0) {
                      isSameDate = false;
                    } else {
                      final String? prevDateString =
                          messageEntity[index - 1].createdAt;
                      final DateTime prevDate = DateTime.parse(prevDateString!);
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
                            MessageCard(message: messageEntity[index]),
                          ]);
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Gap(8.h),
                          MessageCard(message: messageEntity[index]),
                        ],
                      );
                    }
                  },
                ),
              ));
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
  });

  final MessageModel message;

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
                    message.title,
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
                    convertDateToAgo(message.createdAt),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
            Text(
              message.message,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
