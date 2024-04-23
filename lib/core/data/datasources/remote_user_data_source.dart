import 'dart:convert';

import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/data/models/fcm_model.dart';
import 'package:tak/core/data/models/user_model.dart';
import 'package:tak/core/domain/usecases/updatate_user_fcm_token.dart';
import 'package:tak/core/error/execptions.dart';
import 'package:tak/core/services/secure_storage.dart';

class UserDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  UserDataSource({required this.secureStorage, required this.client});

  Future<UserModel> getUserData() async {
    final token = await secureStorage.getToken();
    if (token == null) throw UnauthException();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse("${endpoint}auth/me");
    var response = await client.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return UserModel.fromJson(data['data']);
    } else if (response.statusCode == 401) {
      secureStorage.clearAll();
      throw UnauthException();
    } else {
      throw ServerException();
    }
  }

  Future<FCMModel> updateFCMToken(FCMParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw UnauthException();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse("${endpoint}set-token");
    var response = await client.post(
      url,
      headers: headers,
      body: {
        "fcm_token": params.token,
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return FCMModel.fromJson(data);
    } else if (response.statusCode == 401) {
      secureStorage.clearAll();
      throw UnauthException();
    } else {
      throw ServerException();
    }
  }
}
