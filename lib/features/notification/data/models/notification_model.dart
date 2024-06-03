// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class NotificationModel {
  dynamic id;
  dynamic user_id;
  String subject;
  String message;
  dynamic document;
  String created_at;
  String updated_at;
  NotificationModel({
    required this.id,
    required this.user_id,
    required this.subject,
    required this.message,
    required this.document,
    required this.created_at,
    required this.updated_at,
  });

  NotificationModel copyWith({
    dynamic? id,
    dynamic? user_id,
    String? subject,
    String? message,
    dynamic? document,
    String? created_at,
    String? updated_at,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      document: document ?? this.document,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'subject': subject,
      'message': message,
      'document': document,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as dynamic,
      user_id: map['user_id'] as dynamic,
      subject: map['subject'] as String,
      message: map['message'] as String,
      document: map['document'] as dynamic,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, user_id: $user_id, subject: $subject, message: $message, document: $document, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.subject == subject &&
        other.message == message &&
        other.document == document &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        subject.hashCode ^
        message.hashCode ^
        document.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
