import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tak/core/utils/colors.dart';

class NotificationService {
  static void initialize() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: primaryColor,
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
  }

  // static Future<void> display(RemoteMessage message) async {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //     id: 10,
  //     channelKey: 'basic_channel',
  //     actionType: ActionType.Default,
  //     title: message.notification!.title,
  //     body: message.notification!.body,
  //   ));

  //   InAppNotifications.show(
  //       title: message.notification!.title,
  //       leading: const Icon(
  //         Icons.notifications_active,
  //         color: primaryColor,
  //         size: 50,
  //       ),
  //       description: message.notification!.body,
  //       onTap: () {
  //         // Do whatever you need!
  //       });
  // }
}
