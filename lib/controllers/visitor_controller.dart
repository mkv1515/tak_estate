import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tak/features/visitors/data/models/visitors_model.dart';

import '../core/constants/constants.dart';
import '../core/constants/network_manager.dart';
import '../core/utils/helpers.dart';
import 'auth_controller.dart';

class VisitorController extends GetxController {
  final NetworkManager _networkManager = NetworkManager();
  var dateNow = DateFormat("dd/MM/yyyy").add_jm().format(DateTime.now());
  final controller = Get.put(AuthController());
  RxBool isEmpty = false.obs;
  final RxList<VisitorsModel?> visitorList = RxList<VisitorsModel>([]);

  Future<void> getVisitor() async {
    final email = controller.userProfile.value?.email;
    Logger().d(email);

    bool isConnected = await _networkManager.isConnected();
    if (isConnected) {
      try {
        final response = await clientSupaBase
            .from("VisitorRequest")
            .select()
            .eq('tenantEmail', email!)
            .order('id', ascending: false);

        Logger().d(response);
        if (response.isEmpty) {
          isEmpty.value = true;
        } else {
          isEmpty.value = false;
        }
        final dataList = response as List;
        visitorList.value =
            dataList.map((json) => VisitorsModel.fromMap(json)).toList();

        // Logger().d visitorList.first?.name);
      } on SocketException catch (_) {
        Logger().w(noInternetTxt);
        toast(noInternetTxt);
      } on PostgrestException catch (e) {
        Logger()
            .e('Database Error Message: ${"${e.details} Code : ${e.code}"}');
      } catch (e) {
        Logger().e(e.toString());
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
