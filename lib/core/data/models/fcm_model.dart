import 'package:tak/core/domain/entities/fcm_entity.dart';

class FCMModel extends FCMEntity {
  FCMModel({required super.status, required super.message});

  factory FCMModel.fromJson(Map<String, dynamic> json) {
    return FCMModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
    };
  }
}
