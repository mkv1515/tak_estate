// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class MessageModel {
  dynamic id;
  dynamic user_id;
  String title;
  String message;
  dynamic status;
  String created_at;
  String updated_at;
  MessageModel({
    required this.id,
    required this.user_id,
    required this.title,
    required this.message,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  MessageModel copyWith({
    dynamic? id,
    dynamic? user_id,
    String? title,
    String? message,
    dynamic? status,
    String? created_at,
    String? updated_at,
  }) {
    return MessageModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      title: title ?? this.title,
      message: message ?? this.message,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'title': title,
      'message': message,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as dynamic,
      user_id: map['user_id'] as dynamic,
      title: map['title'] as String,
      message: map['message'] as String,
      status: map['status'] as dynamic,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, user_id: $user_id, title: $title, message: $message, status: $status, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.title == title &&
        other.message == message &&
        other.status == status &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        title.hashCode ^
        message.hashCode ^
        status.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
