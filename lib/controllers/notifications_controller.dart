import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/constants/dio_helper.dart';
import 'package:tak/core/constants/store_value.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/notification/data/models/notification_model.dart';

import '../core/constants/network_manager.dart';

class NotificationsController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  final RxList<NotificationModel> notificationsList =
      RxList<NotificationModel>([]);

  RxString? token = "".obs;

  Future<void> getNotifications() async {
    bool isConnected = await _networkManager.isConnected();

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };

      try {
        var response =
            await dio.get('notifications', options: Options(headers: headers));
        if (response.statusCode == 200) {
          //  Logger().i(response.data['data']);
          final dataList = response.data['data'] as List;
          notificationsList.value =
              dataList.map((json) => NotificationModel.fromMap(json)).toList();
          //Logger().i(notificationsList.first.message.toString());
        } else {
          Logger().i(response.statusMessage);
        }
      } on DioException catch (e) {
        Logger().e(e.message);
      }
    } else {
      toast(noInternetTxt);
      Logger().w(noInternetTxt);
    }
  }
}
