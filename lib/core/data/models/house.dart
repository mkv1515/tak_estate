// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class House {
  dynamic id;
  String name;
  String house_no;
  dynamic house_type_id;
  String furnitures;
  String? description;
  String? rent_id;
  dynamic occupied;
  String created_at;
  String updated_at;
  House({
    required this.id,
    required this.name,
    required this.house_no,
    required this.house_type_id,
    required this.furnitures,
    this.description,
    this.rent_id,
    required this.occupied,
    required this.created_at,
    required this.updated_at,
  });

  House copyWith({
    dynamic? id,
    String? name,
    String? house_no,
    dynamic? house_type_id,
    String? furnitures,
    String? description,
    String? rent_id,
    dynamic? occupied,
    String? created_at,
    String? updated_at,
  }) {
    return House(
      id: id ?? this.id,
      name: name ?? this.name,
      house_no: house_no ?? this.house_no,
      house_type_id: house_type_id ?? this.house_type_id,
      furnitures: furnitures ?? this.furnitures,
      description: description ?? this.description,
      rent_id: rent_id ?? this.rent_id,
      occupied: occupied ?? this.occupied,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'house_no': house_no,
      'house_type_id': house_type_id,
      'furnitures': furnitures,
      'description': description,
      'rent_id': rent_id,
      'occupied': occupied,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      id: map['id'] as dynamic,
      name: map['name'] as String,
      house_no: map['house_no'] as String,
      house_type_id: map['house_type_id'] as dynamic,
      furnitures: map['furnitures'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      rent_id: map['rent_id'] != null ? map['rent_id'] as String : null,
      occupied: map['occupied'] as dynamic,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory House.fromJson(String source) =>
      House.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'House(id: $id, name: $name, house_no: $house_no, house_type_id: $house_type_id, furnitures: $furnitures, description: $description, rent_id: $rent_id, occupied: $occupied, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant House other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.house_no == house_no &&
        other.house_type_id == house_type_id &&
        other.furnitures == furnitures &&
        other.description == description &&
        other.rent_id == rent_id &&
        other.occupied == occupied &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        house_no.hashCode ^
        house_type_id.hashCode ^
        furnitures.hashCode ^
        description.hashCode ^
        rent_id.hashCode ^
        occupied.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
