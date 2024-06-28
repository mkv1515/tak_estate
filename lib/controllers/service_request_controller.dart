import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tak/core/constants/dio_helper.dart';
import 'package:tak/core/constants/store_value.dart';
import 'package:tak/core/widgets/tak_bottom_navigation.dart';
import 'package:tak/features/service_request/data/models/service_requests_model.dart';
import 'package:tak/features/transactions/data/model/balance_model.dart';

import '../core/constants/constants.dart';
import '../core/constants/network_manager.dart';
import '../core/utils/helpers.dart';
import 'auth_controller.dart';

class ServiceRequestController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  var dateNow = DateFormat("dd/MM/yyyy").add_jm().format(DateTime.now());
  final controller = Get.put(AuthController());
  final RxList<ServiceRequestsModel?> serviceList =
      RxList<ServiceRequestsModel>([]);
  RxBool isEmpty = false.obs;
  RxString? token = "".obs;
  RxString userEmail = "".obs;

  Rx<BalanceModel?> balance = Rx<BalanceModel?>(null);

  Future<void> getBalance() async {
    bool isConnected = await _networkManager.isConnected();

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      try {
        var response = await dio.get(
          'transactions/balance',
          options: Options(headers: headers),
        );

      final data = json.encode(response.data['data']);
        Logger().i(data);

        if (response.statusCode == 200) {
          balance.value = BalanceModel.fromJson(data);
          Logger().d(balance.value?.rent_Balance);
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

  Future<void> getServiceRequest() async {
    bool isConnected = await _networkManager.isConnected();

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      try {
        var response = await dio.get(
          'services',
          options: Options(headers: headers),
        );

        final data = response.data['data'];

        final dataList = response.data['data'] as List;
        serviceList.value =
            dataList.map((json) => ServiceRequestsModel.fromMap(json)).toList();

        // Logger().d visitorList.first?.name);
        if (response.statusCode == 200) {
          //Logger().i(data);
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

  Future<void> addServiceRequest(String description, name, priority, houseId,
      section, maintenance, location) async {
    bool isConnected = await _networkManager.isConnected();

//date format
    // DateTime now = DateTime.now();
    // DateFormat formatterspan = DateFormat('yyyy-MM-dd');
    // String datespan = formatterspan.format(now);
    // DateFormat formattertime = DateFormat('hh:mm:ss');
    // String timespan = formattertime.format(now);

    //final arrival = "$datespan $timespan";
    //final dateNow = "$datespan $timespan";

    Logger().i(
        "$description, $name, $priority, $houseId, $section, $maintenance, $location");

    token?.value = (await readValue('token'))!;
    var headers = {
      'Authorization': 'Bearer $token',
    };
    if (isConnected) {
      try {
        var response = await dio.post('services/create',
            options: Options(headers: headers),
            data: json.encode({
              "description": "$description",
              "name": "$name",
              "priority": "$priority",
              "house_id": int.parse(houseId.toString()),
              "section": "$section",
              "location": location,
              "maintenance": maintenance

              // "description": description,
              // "name": name,
              // "priority": priority,
              // "house_id": houseId,
              // "section": section,
              // "location": location,
              // "maintenance": maintenance
            }));

        final data = response.data;

        if (response.statusCode == 200) {
          Logger().i(data);
          toast("Service Request created!");
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
