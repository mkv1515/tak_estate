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
import 'package:tak/features/transactions/data/model/invoice_model.dart';
import 'package:tak/features/transactions/data/model/payment_model.dart';

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
  final RxList<InvoiceModel?> invoiceList = RxList<InvoiceModel>([]);
  final RxList<PaymentModel?> paymentList = RxList<PaymentModel>([]);
  Future<void> getTransactions() async {
    bool isConnected = await _networkManager.isConnected();

    if (isConnected) {
      token?.value = (await readValue('token'))!;
      var headers = {
        'Authorization': 'Bearer $token',
      };
      try {
        var response = await dio.get(
          'transactions',
          options: Options(headers: headers),
        );

        final data = response.data['data'];
        Logger().i(data['payments']);

        final dataList1 = data['invoices'] as List;
        invoiceList.value =
            dataList1.map((json) => InvoiceModel.fromMap(json)).toList();

        final dataList2 = data['payments'] as List;
        paymentList.value =
            dataList2.map((json) => PaymentModel.fromMap(json)).toList();

        Logger().d(paymentList.first?.preparedBy);
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

  @override
  void onInit() {
    super.onInit();
    // Initialization code here
    Logger().d("getBalance Controller initialized");
    // Example: Fetch initial data
    getBalance();
    getTransactions();
  }

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
        // Logger().i(data);

        if (response.statusCode == 200) {
          balance.value = BalanceModel.fromJson(data);
          // Logger().d(balance.value?.rent_Balance);
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


}
