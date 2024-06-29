// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class PaymentModel {
  final dynamic id;
  final dynamic tenant_id;
  final dynamic house_id;
  final dynamic invoice_id;
  final String payment_type;
  final dynamic charge;
  final dynamic amount;
  final dynamic balance;
  final String payment_method;
  final String preparedBy;
  final String currency;
  final dynamic description;
  final String type;
  final dynamic last_payment_date;
  final dynamic status;
  final String created_at;
  final String updated_at;
  PaymentModel({
    required this.id,
    required this.tenant_id,
    required this.house_id,
    required this.invoice_id,
    required this.payment_type,
    required this.charge,
    required this.amount,
    required this.balance,
    required this.payment_method,
    required this.preparedBy,
    required this.currency,
    required this.description,
    required this.type,
    required this.last_payment_date,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  PaymentModel copyWith({
    dynamic? id,
    dynamic? tenant_id,
    dynamic? house_id,
    dynamic? invoice_id,
    String? payment_type,
    dynamic? charge,
    dynamic? amount,
    dynamic? balance,
    String? payment_method,
    String? preparedBy,
    String? currency,
    dynamic? description,
    String? type,
    dynamic? last_payment_date,
    dynamic? status,
    String? created_at,
    String? updated_at,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      tenant_id: tenant_id ?? this.tenant_id,
      house_id: house_id ?? this.house_id,
      invoice_id: invoice_id ?? this.invoice_id,
      payment_type: payment_type ?? this.payment_type,
      charge: charge ?? this.charge,
      amount: amount ?? this.amount,
      balance: balance ?? this.balance,
      payment_method: payment_method ?? this.payment_method,
      preparedBy: preparedBy ?? this.preparedBy,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      type: type ?? this.type,
      last_payment_date: last_payment_date ?? this.last_payment_date,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tenant_id': tenant_id,
      'house_id': house_id,
      'invoice_id': invoice_id,
      'payment_type': payment_type,
      'charge': charge,
      'amount': amount,
      'balance': balance,
      'payment_method': payment_method,
      'preparedBy': preparedBy,
      'currency': currency,
      'description': description,
      'type': type,
      'last_payment_date': last_payment_date,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as dynamic,
      tenant_id: map['tenant_id'] as dynamic,
      house_id: map['house_id'] as dynamic,
      invoice_id: map['invoice_id'] as dynamic,
      payment_type: map['payment_type'] as String,
      charge: map['charge'] as dynamic,
      amount: map['amount'] as dynamic,
      balance: map['balance'] as dynamic,
      payment_method: map['payment_method'] as String,
      preparedBy: map['preparedBy'] as String,
      currency: map['currency'] as String,
      description: map['description'] as dynamic,
      type: map['type'] as String,
      last_payment_date: map['last_payment_date'] as dynamic,
      status: map['status'] as dynamic,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) => PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentModel(id: $id, tenant_id: $tenant_id, house_id: $house_id, invoice_id: $invoice_id, payment_type: $payment_type, charge: $charge, amount: $amount, balance: $balance, payment_method: $payment_method, preparedBy: $preparedBy, currency: $currency, description: $description, type: $type, last_payment_date: $last_payment_date, status: $status, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.tenant_id == tenant_id &&
      other.house_id == house_id &&
      other.invoice_id == invoice_id &&
      other.payment_type == payment_type &&
      other.charge == charge &&
      other.amount == amount &&
      other.balance == balance &&
      other.payment_method == payment_method &&
      other.preparedBy == preparedBy &&
      other.currency == currency &&
      other.description == description &&
      other.type == type &&
      other.last_payment_date == last_payment_date &&
      other.status == status &&
      other.created_at == created_at &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tenant_id.hashCode ^
      house_id.hashCode ^
      invoice_id.hashCode ^
      payment_type.hashCode ^
      charge.hashCode ^
      amount.hashCode ^
      balance.hashCode ^
      payment_method.hashCode ^
      preparedBy.hashCode ^
      currency.hashCode ^
      description.hashCode ^
      type.hashCode ^
      last_payment_date.hashCode ^
      status.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;
  }
}
