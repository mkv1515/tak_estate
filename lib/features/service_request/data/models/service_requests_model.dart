// ignore_for_file: non_constant_identifier_names, unnecessary_question_mark

import 'dart:convert';

class ServiceRequestsModel {
  final dynamic id;
  final dynamic house_id;
  final String name;
  final dynamic lifespan;
  final String description;
  final dynamic user_id;
  final String priority;
  final String location;
  final dynamic section;
  final String maintenance;
  final dynamic status;
  final dynamic amount;
  final String? comment;
  final String? document;
  final String created_at;
  final String updated_at;

  ServiceRequestsModel({
    required this.id,
    required this.house_id,
    required this.name,
    required this.lifespan,
    required this.description,
    required this.user_id,
    required this.priority,
    required this.location,
    required this.section,
    required this.maintenance,
    required this.status,
    required this.amount,
    this.comment,
    this.document,
    required this.created_at,
    required this.updated_at,
  });

  ServiceRequestsModel copyWith({
    dynamic? id,
    dynamic? house_id,
    String? name,
    dynamic? lifespan,
    String? description,
    dynamic? user_id,
    String? priority,
    String? location,
    dynamic? section,
    String? maintenance,
    dynamic? status,
    dynamic? amount,
    String? comment,
    String? document,
    String? created_at,
    String? updated_at,
  }) {
    return ServiceRequestsModel(
      id: id ?? this.id,
      house_id: house_id ?? this.house_id,
      name: name ?? this.name,
      lifespan: lifespan ?? this.lifespan,
      description: description ?? this.description,
      user_id: user_id ?? this.user_id,
      priority: priority ?? this.priority,
      location: location ?? this.location,
      section: section ?? this.section,
      maintenance: maintenance ?? this.maintenance,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      comment: comment ?? this.comment,
      document: document ?? this.document,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'house_id': house_id,
      'name': name,
      'lifespan': lifespan,
      'description': description,
      'user_id': user_id,
      'priority': priority,
      'location': location,
      'section': section,
      'maintenance': maintenance,
      'status': status,
      'amount': amount,
      'comment': comment,
      'document': document,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory ServiceRequestsModel.fromMap(Map<String, dynamic> map) {
    return ServiceRequestsModel(
      id: map['id'] as dynamic,
      house_id: map['house_id'] as dynamic,
      name: map['name'] as String,
      lifespan: map['lifespan'] as dynamic,
      description: map['description'] as String,
      user_id: map['user_id'] as dynamic,
      priority: map['priority'] as String,
      location: map['location'] as String,
      section: map['section'] as dynamic,
      maintenance: map['maintenance'] as String,
      status: map['status'] as dynamic,
      amount: map['amount'] as dynamic,
      comment: map['comment'] != null ? map['comment'] as String : null,
      document: map['document'] != null ? map['document'] as String : null,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestsModel.fromJson(String source) => ServiceRequestsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceRequestsModel(id: $id, house_id: $house_id, name: $name, lifespan: $lifespan, description: $description, user_id: $user_id, priority: $priority, location: $location, section: $section, maintenance: $maintenance, status: $status, amount: $amount, comment: $comment, document: $document, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant ServiceRequestsModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.house_id == house_id &&
      other.name == name &&
      other.lifespan == lifespan &&
      other.description == description &&
      other.user_id == user_id &&
      other.priority == priority &&
      other.location == location &&
      other.section == section &&
      other.maintenance == maintenance &&
      other.status == status &&
      other.amount == amount &&
      other.comment == comment &&
      other.document == document &&
      other.created_at == created_at &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      house_id.hashCode ^
      name.hashCode ^
      lifespan.hashCode ^
      description.hashCode ^
      user_id.hashCode ^
      priority.hashCode ^
      location.hashCode ^
      section.hashCode ^
      maintenance.hashCode ^
      status.hashCode ^
      amount.hashCode ^
      comment.hashCode ^
      document.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;
  }
}
