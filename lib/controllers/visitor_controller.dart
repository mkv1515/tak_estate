import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tak/controllers/service_request_controller.dart';
import 'package:tak/core/constants/dio_helper.dart';
import 'package:tak/core/widgets/tak_bottom_navigation.dart';
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
          'visitors',
          options: Options(headers: headers),
        );

        final data = response.data['data'];

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
    final tenantPhone = controller.userProfile.value?.phone;
    final tenantEmail = controller.userProfile.value?.email;

    Logger().i(
        "$visitorName, $visitorPhoneNumber, $reason, $arrival, $departure, $tenantPhone, $tenantEmail");

    if (isConnected) {
      try {
        final response = await clientSupaBase.from("VisitorRequest").insert({
          'created_at': dateNow,
          'tenantPhone': tenantPhone,
          'tenantEmail': tenantEmail,
          'phone': visitorPhoneNumber,
          'arrival': arrival,
          'departure': departure,
          'reason': reason,
          'visitor_name': visitorName
        });
        Logger().i("Response: $response");
        toast("Visitor created successfully");
        // Get.back();
        Get.off(() => const TakBottomNavigation());
      } on PostgrestException catch (e) {
        Logger().e(e.code);
      } catch (e) {
        Logger().e(e.hashCode);
      }
    } else {
      toast(noInternetTxt);
      Logger().w(noInternetTxt);
    }
  }
}
