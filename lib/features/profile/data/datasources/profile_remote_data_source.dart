import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tak/core/constants/constants.dart';
import 'package:tak/core/error/execptions.dart';
import 'package:tak/core/services/secure_storage.dart';
import 'package:tak/features/profile/data/models/profile_model.dart';
import 'package:tak/features/profile/data/models/profile_photo_model.dart';
import 'package:tak/features/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> updateProfile(ProfileParams params);
  Future<ProfilePhotoModel> updateProfilePhoto(params);
  Future<ProfileModel> changePassword(params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  ProfileRemoteDataSourceImpl({
    required this.secureStorage,
    required this.client,
  });

  @override
  Future<ProfileModel> updateProfile(ProfileParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw UnauthException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}account/update-profile");
    var response = await client.post(
      url,
      body: {
        "phone": params.telephone,
        "gender": params.gender,
        "name": params.name,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 401) {
      secureStorage.clearAll();
      throw UnauthException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfilePhotoModel> updateProfilePhoto(params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw UnauthException();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse('${endpoint}account/update-photo');
    var request = http.MultipartRequest(
      'POST',
      url,
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', params.path),
    );
    request.headers.addAll(headers);
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return ProfilePhotoModel.fromJson(data);
    } else if (response.statusCode == 401) {
      secureStorage.clearAll();
      throw UnauthException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> changePassword(params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw UnauthException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}account/change-password");
    var response = await client.post(
      url,
      body: {
        "password": params.password,
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 401) {
      secureStorage.clearAll();
      throw UnauthException();
    } else {
      throw ServerException();
    }
  }
}
