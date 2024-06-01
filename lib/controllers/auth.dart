import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:tak/core/utils/helpers.dart';

import '../core/constants/constants.dart';
import '../core/constants/dio_helper.dart';
import '../core/widgets/tak_bottom_navigation.dart';
import '../features/auth/data/models/auth_model.dart';

class Auth extends GetxController {
  // final email = TextEditingController();
  // final password = TextEditingController();

  var isButtonEnabled = true.obs;

  Future<void> loginUser(String email, password) async {
    final dynamic emailString = email.trim();
    final dynamic passwordString = password.trim();
    // UserLogin userModel =
    //     UserLogin(username: emailString, password: passwordString);

    // var errorMessage = _validateForm();
    // debugPrint(errorMessage);

    try {
      // Disable the button to prevent multiple submissions
      isButtonEnabled.value = false;
      final response = await dio
          .post('auth/login', data: {"email": email, "password": password});

      //final token = response.data['responseBody']['token'].toString();
      //storeValue(valueName: 'token', value: token);
      final data = json.decode(response.data);
      Logger().i(data["status"]);
      isButtonEnabled.value = true;

      if (response.statusCode == 200) {
        // if (json.decode(response.data[0]['status']) == false) {
        //   toast(messageTxt);
        //   //Logger().e(messageTxt);
        // } else {
        //   toast("Loggin Successful.");
        //   // Logger().d("Loggin Successful.");
        //   AuthModel.fromJson(response.data['data']);
        //   Get.offAll(() => const TakBottomNavigation(),
        //       transition: Transition.cupertino);
        // }
      }
    } on SocketException catch (_) {
      isButtonEnabled.value = true;
      debugPrint(noInternetTxt);

      toast(noInternetTxt);
      Logger().w(noInternetTxt);
    } on DioException catch (e) {
      isButtonEnabled.value = true;
      debugPrint(e.response?.statusMessage.toString());
      //Logger().e(e.response?.statusMessage.toString());

      // toast(e.response!.statusMessage.toString());
    }
  }
}
