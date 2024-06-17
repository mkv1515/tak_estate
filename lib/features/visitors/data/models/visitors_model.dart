// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class VisitorsModel {
  dynamic id;
  dynamic user_id;
  String? phone;
  String? arrival;
  String? departure;
  dynamic house_id;
  String? car_regno;
  String? reason;
  String? destination;
  String? check_in;
  String? check_out;
  String? visitor_name;
  String? created_at;
  String? updated_at;
  VisitorsModel({
    required this.id,
    required this.user_id,
    this.phone,
    this.arrival,
    this.departure,
    required this.house_id,
    this.car_regno,
    this.reason,
    this.destination,
    this.check_in,
    this.check_out,
    this.visitor_name,
    this.created_at,
    this.updated_at,
  });

  VisitorsModel copyWith({
    dynamic? id,
    dynamic? user_id,
    String? phone,
    String? arrival,
    String? departure,
    dynamic? house_id,
    String? car_regno,
    String? reason,
    String? destination,
    String? check_in,
    String? check_out,
    String? visitor_name,
    String? created_at,
    String? updated_at,
  }) {
    return VisitorsModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      phone: phone ?? this.phone,
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
      house_id: house_id ?? this.house_id,
      car_regno: car_regno ?? this.car_regno,
      reason: reason ?? this.reason,
      destination: destination ?? this.destination,
      check_in: check_in ?? this.check_in,
      check_out: check_out ?? this.check_out,
      visitor_name: visitor_name ?? this.visitor_name,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'phone': phone,
      'arrival': arrival,
      'departure': departure,
      'house_id': house_id,
      'car_regno': car_regno,
      'reason': reason,
      'destination': destination,
      'check_in': check_in,
      'check_out': check_out,
      'visitor_name': visitor_name,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory VisitorsModel.fromMap(Map<String, dynamic> map) {
    return VisitorsModel(
      id: map['id'] as dynamic,
      user_id: map['user_id'] as dynamic,
      phone: map['phone'] != null ? map['phone'] as String : null,
      arrival: map['arrival'] != null ? map['arrival'] as String : null,
      departure: map['departure'] != null ? map['departure'] as String : null,
      house_id: map['house_id'] as dynamic,
      car_regno: map['car_regno'] != null ? map['car_regno'] as String : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
      destination: map['destination'] != null ? map['destination'] as String : null,
      check_in: map['check_in'] != null ? map['check_in'] as String : null,
      check_out: map['check_out'] != null ? map['check_out'] as String : null,
      visitor_name: map['visitor_name'] != null ? map['visitor_name'] as String : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      updated_at: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitorsModel.fromJson(String source) => VisitorsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VisitorsModel(id: $id, user_id: $user_id, phone: $phone, arrival: $arrival, departure: $departure, house_id: $house_id, car_regno: $car_regno, reason: $reason, destination: $destination, check_in: $check_in, check_out: $check_out, visitor_name: $visitor_name, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant VisitorsModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.user_id == user_id &&
      other.phone == phone &&
      other.arrival == arrival &&
      other.departure == departure &&
      other.house_id == house_id &&
      other.car_regno == car_regno &&
      other.reason == reason &&
      other.destination == destination &&
      other.check_in == check_in &&
      other.check_out == check_out &&
      other.visitor_name == visitor_name &&
      other.created_at == created_at &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      phone.hashCode ^
      arrival.hashCode ^
      departure.hashCode ^
      house_id.hashCode ^
      car_regno.hashCode ^
      reason.hashCode ^
      destination.hashCode ^
      check_in.hashCode ^
      check_out.hashCode ^
      visitor_name.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;
  }
}
