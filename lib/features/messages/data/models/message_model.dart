// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  dynamic id;
  String title;
  String message;
  String createdAt;
  MessageModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  MessageModel copyWith({
    dynamic? id,
    String? title,
    String? message,
    String? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as dynamic,
      title: map['title'] as String,
      message: map['message'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, title: $title, message: $message, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.title == title &&
      other.message == message &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      message.hashCode ^
      createdAt.hashCode;
  }
}
