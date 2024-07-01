// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tak/core/constants/dio_helper.dart';
import 'package:tak/core/widgets/tak_bottom_navigation.dart';
import 'package:tak/features/security/data/models/security_visitors_model.dart';
import 'package:tak/features/security/domain/entities/security_visitors_entity.dart';
import 'package:tak/features/visitors/data/models/visitors_model.dart';

import '../core/constants/constants.dart';
import '../core/constants/network_manager.dart';
import '../core/constants/store_value.dart';
import '../core/utils/helpers.dart';
import 'auth_controller.dart';

class VisitorController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  var dateNow = DateFormat("dd/MM/yyyy").add_jm().format(DateTime.now());
  final controller = Get.put(AuthController());
  RxBool isEmpty = false.obs;
  final RxList<VisitorsModel?> visitorList = RxList<VisitorsModel>([]);
  RxString? token = "".obs;
  final RxList<SecurityVisitorEntity?> visitorSecurityList =
      RxList<SecurityVisitorEntity>([]);

  Future<void> checkIn(dynamic Id) async {
    bool isConnected = await _networkManager.isConnected();
    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      Logger().i("id === $Id");

      try {
        var response = await dio.get('visitors/security/check-in/$Id',
            options: Options(headers: headers));

        final data = response.data;

        if (response.statusCode == 200) {
          Logger().i(data);
          toast("Visitor Check In successfully");
          //Get.off(() => const TakBottomNavigation());
          update();
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

  Future<void> checkOut(dynamic Id) async {
    bool isConnected = await _networkManager.isConnected();
    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      Logger().i("id === $Id");

      try {
        var response = await dio.get('visitors/security/check-out/$Id',
            options: Options(headers: headers));

        final data = response.data;

        if (response.statusCode == 200) {
          Logger().i(data);
          toast("Visitor Check Out successfully");
          //Get.off(() => const TakBottomNavigation());
          update();
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

  Future<void> getVisitorSecurity() async {
    bool isConnected = await _networkManager.isConnected();

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      try {
        var response = await dio.get(
          'visitors/security',
          options: Options(headers: headers),
        );

        final dataList = response.data['data'] as List;
        visitorSecurityList.value = dataList
            .map((json) => SecurityVisitorModel.fromJson(json))
            .toList();

        // Logger().i(response);

        //Logger().i(visitorSecurityList.first?.houseNo);
        if (response.statusCode == 200) {
          // toast("Profile Updated");
          // Get.off(() => const TakBottomNavigation());
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

  Future<void> getVisitor() async {
    bool isConnected = await _networkManager.isConnected();
    // Logger().d("email from storage $email");

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      try {
        var response = await dio.get(
          'visitors/myVisitor',
          options: Options(headers: headers),
        );

        //final data = response.data['data'];

        final dataList = response.data['data'] as List;
        visitorList.value =
            dataList.map((json) => VisitorsModel.fromMap(json)).toList();

        // Logger().d visitorList.first?.name);
        if (response.statusCode == 200) {
          //  Logger().i(data);
          // toast("Profile Updated");
          // Get.off(() => const TakBottomNavigation());
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

  Future<void> addVistor(String visitorName, visitorPhoneNumber, reason,
      arrival, departure) async {
    bool isConnected = await _networkManager.isConnected();
    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      final house = controller.house.value?.name;
      Logger().i(
          "$visitorName, $visitorPhoneNumber, $reason, $arrival, $departure, $house");

      try {
        var response = await dio
            .post('visitors/create', options: Options(headers: headers), data: {
          "phone": "",
          "arrival": arrival,
          "departure": null,
          "car_regno": null,
          "reason": "",
          "destination": house,
          "visitor_name": visitorName
        });

        final data = response.data;

        if (response.statusCode == 200) {
          Logger().i(data);
          toast("Visitor created successfully");
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
}
