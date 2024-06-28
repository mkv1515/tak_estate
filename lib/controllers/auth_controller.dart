import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:tak/core/data/models/house.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/features/security/presentation/pages/security.dart';

import '../core/constants/constants.dart';
import '../core/constants/dio_helper.dart';
import '../core/constants/store_value.dart';
import '../core/data/models/user_model.dart';
import '../core/widgets/tak_bottom_navigation.dart';

class AuthController extends GetxController {
  var isButtonEnabled = true.obs;
  RxString? token = "".obs;
  Rx<UserModel?> userProfile = Rx<UserModel?>(null);
  Rx<House?> house = Rx<House?>(null);
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    autoLogin();
  }

  Future<void> getUserData() async {
    token?.value = (await readValue('token'))!;
    var headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      var response =
          await dio.get('auth/me', options: Options(headers: headers));
      final data = json.decode(response.data);

      final role = data['data']['role'];
      // Logger().d(role);

      if (response.statusCode == 200) {
        userProfile.value = UserModel.fromJson(data['data']);

        if (role == "security") {
          Get.off(() => const Security());
        } else {
          final houseName = data['data']['tenant_house']['house'];
          house.value = House.fromMap(houseName);
        }

        //storeValue(valueName: 'email', value: email ?? "");
        //Logger().i(houseName);

        //Logger().i(userProfile.value?.role);
      } else {
        Logger().e(response.statusMessage);
      }
    } on DioException catch (e) {
      Logger().e(e.message);
    }
  }

  Future<void> loginUser(String email, password) async {
    try {
      // Disable the button to prevent multiple submissions
      isButtonEnabled.value = false;
      final response = await dio
          .post('auth/login', data: {"email": email, "password": password});
      final data = json.decode(response.data);

      isButtonEnabled.value = true;

      if (response.statusCode == 200) {
        if (data['status'] == false) {
          Logger().e(messageTxt);
          return toast(messageTxt);
        }
        final token = data['data']['access_token'].toString();

        storeValue(valueName: 'token', value: token);
        isLoggedIn.value = true;

        //Logger().i(data);

        toast("Loggin Successful.");
        Logger().d("Loggin Successful.");
        Get.offAll(() => const TakBottomNavigation(),
            transition: Transition.cupertino);
      }
    } on SocketException catch (_) {
      isButtonEnabled.value = true;
      toast(noInternetTxt);
      Logger().w(noInternetTxt);
    } on DioException catch (e) {
      isButtonEnabled.value = true;
      Logger().e(e.response?.statusMessage.toString());
      toast(e.response!.statusMessage.toString());
    }
  }

  Future<void> autoLogin() async {
    String? token = (await readValue('token'))!;
    if (token.isNotEmpty) {
      isLoggedIn.value = true;
    }
  }

  Future<void> logout() async {
    deleteAllValue();
    isLoggedIn.value = false;
  }
}
