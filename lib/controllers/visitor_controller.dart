import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/constants.dart';
import '../core/constants/network_manager.dart';
import '../core/utils/helpers.dart';
import 'auth_controller.dart';

class ServiceRequestController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  var dateNow = DateFormat("dd/MM/yyyy").add_jm().format(DateTime.now());
  final controller = Get.put(AuthController());

  Future<void> addServiceRequest(String description, name, priority, houseId,
      section, maintenance, location) async {
    bool isConnected = await _networkManager.isConnected();
    final phone = controller.userProfile.value?.phone;
    final email = controller.userProfile.value?.email;

    Logger().i(
        "$description, $name, $priority, $houseId, $section, $maintenance, $location, $phone, $email");

    if (isConnected) {
      try {
        final response = await clientSupaBase.from("ServiceRequest").insert({
          'description': description,
          'name': name,
          'priority': priority,
          'houseId': houseId,
          'section': section.toString(),
          'location': location,
          'maintenance': maintenance,
          'created_at': dateNow,
          'phone': phone,
          'email': email
        });
        Logger().i("Response: $response");
        toast("Service Request created!");
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
