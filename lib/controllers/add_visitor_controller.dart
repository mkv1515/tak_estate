import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';
import 'package:tak/controllers/auth_controller.dart';
import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/constants/dio_helper.dart';
import 'package:tak/core/constants/network_manager.dart';
import 'package:tak/core/constants/store_value.dart';
import 'package:tak/core/utils/helpers.dart';
import 'package:tak/core/widgets/tak_bottom_navigation.dart';
import 'package:tak/features/security/domain/entities/security_visitors_entity.dart';
import 'package:tak/features/visitors/data/models/visitors_model.dart';

class AddVisitorController extends GetxController {
  var submitting = true.obs;

  final NetworkManager _networkManager = NetworkManager();
  var dateNow = DateFormat("dd/MM/yyyy").add_jm().format(DateTime.now());
  final controller = Get.put(AuthController());
  RxBool isEmpty = false.obs;
  final RxList<VisitorsModel?> visitorList = RxList<VisitorsModel>([]);
  RxString? token = "".obs;
  final RxList<SecurityVisitorEntity?> visitorSecurityList =
      RxList<SecurityVisitorEntity>([]);

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
          submitting.value = false;
          Logger().e(response.statusMessage);
        }
        submitting.value = false;
      } on DioException catch (e) {
        submitting.value = false;
        Logger().e(e.message);
      }
    } else {
      submitting.value = false;

      toast(noInternetTxt);
      Logger().w(noInternetTxt);
    }
  }
}
