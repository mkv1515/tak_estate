import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/constants.dart';
import '../core/constants/network_manager.dart';
import '../core/utils/helpers.dart';
import 'auth_controller.dart';

class VisitorController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  var dateNow = DateFormat("dd/MM/yyyy").add_jm().format(DateTime.now());
  final controller = Get.put(AuthController());

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
        Get.back();
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
