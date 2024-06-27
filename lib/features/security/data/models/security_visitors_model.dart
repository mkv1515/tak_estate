import 'package:tak/features/security/domain/entities/security_visitors_entity.dart';

class SecurityVisitorModel extends SecurityVisitorEntity {
  SecurityVisitorModel({
    required super.id,
    required super.visitorName,
    required super.checkIn,
    required super.checkOut,
    required super.arrival,
    required super.departure,
    required super.phone,
    required super.houseNo,
  });

  factory SecurityVisitorModel.fromJson(Map<String, dynamic> json) {
    return SecurityVisitorModel(
      id: json['id'],
      visitorName: json['visitor_name'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      arrival: json['arrival'],
      departure: json['departure'],
      phone: json['phone'],
      houseNo: json['house']['name'],
    );
  }
}
