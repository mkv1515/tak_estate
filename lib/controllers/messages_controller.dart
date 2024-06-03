import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/constants/dio_helper.dart';
import 'package:tak/core/constants/store_value.dart';
import 'package:tak/core/utils/helpers.dart';

import '../core/constants/network_manager.dart';
import '../features/messages/data/models/message_model.dart';

class MessagesController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  final RxList<MessageModel> messageList = RxList<MessageModel>([]);
  Rx<MessageModel?> messageSingle = Rx<MessageModel?>(null);

  RxString? token = "".obs;

  Future<void> getMessages() async {
    bool isConnected = await _networkManager.isConnected();

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };

      try {
        var response =
            await dio.get('messages', options: Options(headers: headers));
        if (response.statusCode == 200) {
          // Logger().i(response.data['data']);
          final dataList = response.data['data'] as List;
          messageList.value =
              dataList.map((json) => MessageModel.fromMap(json)).toList();
          //Logger().i(messageList.first.message);
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
