import 'package:tak/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({required super.status, required super.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
