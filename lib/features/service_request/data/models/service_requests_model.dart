// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ServiceRequestsModel {
  dynamic id;
  String created_at;
  String description;
  String name;
  String priority;
  String houseId;
  String section;
  String location;
  String maintenance;
  String phone;
  String email;
  String status;
  ServiceRequestsModel({
    required this.id,
    required this.created_at,
    required this.description,
    required this.name,
    required this.priority,
    required this.houseId,
    required this.section,
    required this.location,
    required this.maintenance,
    required this.phone,
    required this.email,
    required this.status,
  });

  ServiceRequestsModel copyWith({
    dynamic? id,
    String? created_at,
    String? description,
    String? name,
    String? priority,
    String? houseId,
    String? section,
    String? location,
    String? maintenance,
    String? phone,
    String? email,
    String? status,
  }) {
    return ServiceRequestsModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      description: description ?? this.description,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      houseId: houseId ?? this.houseId,
      section: section ?? this.section,
      location: location ?? this.location,
      maintenance: maintenance ?? this.maintenance,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'description': description,
      'name': name,
      'priority': priority,
      'houseId': houseId,
      'section': section,
      'location': location,
      'maintenance': maintenance,
      'phone': phone,
      'email': email,
      'status': status,
    };
  }

  factory ServiceRequestsModel.fromMap(Map<String, dynamic> map) {
    return ServiceRequestsModel(
      id: map['id'] as dynamic,
      created_at: map['created_at'] as String,
      description: map['description'] as String,
      name: map['name'] as String,
      priority: map['priority'] as String,
      houseId: map['houseId'] as String,
      section: map['section'] as String,
      location: map['location'] as String,
      maintenance: map['maintenance'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestsModel.fromJson(String source) =>
      ServiceRequestsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceRequestsModel(id: $id, created_at: $created_at, description: $description, name: $name, priority: $priority, houseId: $houseId, section: $section, location: $location, maintenance: $maintenance, phone: $phone, email: $email, status: $status)';
  }

  @override
  bool operator ==(covariant ServiceRequestsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.description == description &&
        other.name == name &&
        other.priority == priority &&
        other.houseId == houseId &&
        other.section == section &&
        other.location == location &&
        other.maintenance == maintenance &&
        other.phone == phone &&
        other.email == email &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        description.hashCode ^
        name.hashCode ^
        priority.hashCode ^
        houseId.hashCode ^
        section.hashCode ^
        location.hashCode ^
        maintenance.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        status.hashCode;
  }
}
