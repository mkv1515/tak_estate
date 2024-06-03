// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class VisitorsModel {
  dynamic id;
  String created_at;
  String tenantPhone;
  String tenantEmail;
  String phone;
  String arrival;
  String departure;
  String? car_regno;
  String reason;
  String? destination;
  String visitor_name;
  VisitorsModel({
    required this.id,
    required this.created_at,
    required this.tenantPhone,
    required this.tenantEmail,
    required this.phone,
    required this.arrival,
    required this.departure,
    this.car_regno,
    required this.reason,
    this.destination,
    required this.visitor_name,
  });

  VisitorsModel copyWith({
    dynamic? id,
    String? created_at,
    String? tenantPhone,
    String? tenantEmail,
    String? phone,
    String? arrival,
    String? departure,
    String? car_regno,
    String? reason,
    String? destination,
    String? visitor_name,
  }) {
    return VisitorsModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      tenantPhone: tenantPhone ?? this.tenantPhone,
      tenantEmail: tenantEmail ?? this.tenantEmail,
      phone: phone ?? this.phone,
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
      car_regno: car_regno ?? this.car_regno,
      reason: reason ?? this.reason,
      destination: destination ?? this.destination,
      visitor_name: visitor_name ?? this.visitor_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'tenantPhone': tenantPhone,
      'tenantEmail': tenantEmail,
      'phone': phone,
      'arrival': arrival,
      'departure': departure,
      'car_regno': car_regno,
      'reason': reason,
      'destination': destination,
      'visitor_name': visitor_name,
    };
  }

  factory VisitorsModel.fromMap(Map<String, dynamic> map) {
    return VisitorsModel(
      id: map['id'] as dynamic,
      created_at: map['created_at'] as String,
      tenantPhone: map['tenantPhone'] as String,
      tenantEmail: map['tenantEmail'] as String,
      phone: map['phone'] as String,
      arrival: map['arrival'] as String,
      departure: map['departure'] as String,
      car_regno: map['car_regno'] != null ? map['car_regno'] as String : null,
      reason: map['reason'] as String,
      destination:
          map['destination'] != null ? map['destination'] as String : null,
      visitor_name: map['visitor_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitorsModel.fromJson(String source) =>
      VisitorsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VisitorsModel(id: $id, created_at: $created_at, tenantPhone: $tenantPhone, tenantEmail: $tenantEmail, phone: $phone, arrival: $arrival, departure: $departure, car_regno: $car_regno, reason: $reason, destination: $destination, visitor_name: $visitor_name)';
  }

  @override
  bool operator ==(covariant VisitorsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.tenantPhone == tenantPhone &&
        other.tenantEmail == tenantEmail &&
        other.phone == phone &&
        other.arrival == arrival &&
        other.departure == departure &&
        other.car_regno == car_regno &&
        other.reason == reason &&
        other.destination == destination &&
        other.visitor_name == visitor_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        tenantPhone.hashCode ^
        tenantEmail.hashCode ^
        phone.hashCode ^
        arrival.hashCode ^
        departure.hashCode ^
        car_regno.hashCode ^
        reason.hashCode ^
        destination.hashCode ^
        visitor_name.hashCode;
  }
}
