// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class BalanceModel {
  dynamic rent_Balance;
  dynamic service_Balance;
  BalanceModel({
    required this.rent_Balance,
    required this.service_Balance,
  });

  BalanceModel copyWith({
    dynamic? rent_Balance,
    dynamic? service_Balance,
  }) {
    return BalanceModel(
      rent_Balance: rent_Balance ?? this.rent_Balance,
      service_Balance: service_Balance ?? this.service_Balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rent_Balance': rent_Balance,
      'service_Balance': service_Balance,
    };
  }

  factory BalanceModel.fromMap(Map<String, dynamic> map) {
    return BalanceModel(
      rent_Balance: map['rent_Balance'] as dynamic,
      service_Balance: map['service_Balance'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalanceModel.fromJson(String source) =>
      BalanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BalanceModel(rent_Balance: $rent_Balance, service_Balance: $service_Balance)';

  @override
  bool operator ==(covariant BalanceModel other) {
    if (identical(this, other)) return true;

    return other.rent_Balance == rent_Balance &&
        other.service_Balance == service_Balance;
  }

  @override
  int get hashCode => rent_Balance.hashCode ^ service_Balance.hashCode;
}
