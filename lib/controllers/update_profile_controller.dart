import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_bottom_navigation.dart';
import 'package:tak/features/auth/presentation/pages/login.dart';
import 'package:tak/features/onboard/presentation/pages/onboarding.dart';
import 'package:tak/features/onboard/presentation/widgets/onboard_login_button.dart';

import '../core/constants/constants.dart';
import '../core/constants/dio_helper.dart';
import '../core/constants/network_manager.dart';
import '../core/constants/store_value.dart';

class UpdateProfileController extends GetxController {
  RxString? token = "".obs;
  final NetworkManager _networkManager = NetworkManager();

  Future<void> updateProfile(String phone, gender, name) async {
    bool isConnected = await _networkManager.isConnected();
    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };

      try {
        var response = await dio.post('account/update-profile',
            options: Options(headers: headers),
            data: {
              "phone": phone,
              "gender": gender,
              "name": name,
            });

        final data = response.data;

        if (response.statusCode == 200) {
          Logger().i(data);
          toast("Profile Updated");
          Get.off(() => const TakBottomNavigation());
        } else {
          Logger().e(response.statusMessage);
        }
      } on DioException catch (e) {
        Logger().e(e.message);
      }
    } else {
      toast(noInternetTxt);
      Logger().w(noInternetTxt);
    }
  }

  Future<void> changePassword(String password) async {
    Logger().i("changePassword func $password");

    bool isConnected = await _networkManager.isConnected();
    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };

      try {
        var response = await dio.post('account/change-password',
            options: Options(headers: headers),
            data: {
              "password": password,
            });

        final data = response.data;

        if (response.statusCode == 200) {
          Logger().i(data);
          toast("Password Changed");
          Logger().w("Password Changed");
          Get.offAll(() => const Onboarding());
        } else {
          Logger().e(response.statusMessage);
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
