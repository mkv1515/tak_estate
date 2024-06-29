// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class InvoiceModel {
  final dynamic id;
  final String invoice_no;
  final dynamic invoice_id;
  final dynamic tenant_id;
  final dynamic start_date;
  final String end_date;
  final dynamic rent_id;
  final dynamic status;
  final dynamic currency;
  final String amount;
  final String type;
  final dynamic house_id;
  final dynamic parentId;
  final String created_at;
  final String updated_at;
  InvoiceModel({
    required this.id,
    required this.invoice_no,
    required this.invoice_id,
    required this.tenant_id,
    required this.start_date,
    required this.end_date,
    required this.rent_id,
    required this.status,
    required this.currency,
    required this.amount,
    required this.type,
    required this.house_id,
    required this.parentId,
    required this.created_at,
    required this.updated_at,
  });

  InvoiceModel copyWith({
    dynamic? id,
    String? invoice_no,
    dynamic? invoice_id,
    dynamic? tenant_id,
    dynamic? start_date,
    String? end_date,
    dynamic? rent_id,
    dynamic? status,
    dynamic? currency,
    String? amount,
    String? type,
    dynamic? house_id,
    dynamic? parentId,
    String? created_at,
    String? updated_at,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      invoice_no: invoice_no ?? this.invoice_no,
      invoice_id: invoice_id ?? this.invoice_id,
      tenant_id: tenant_id ?? this.tenant_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      rent_id: rent_id ?? this.rent_id,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      house_id: house_id ?? this.house_id,
      parentId: parentId ?? this.parentId,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'invoice_no': invoice_no,
      'invoice_id': invoice_id,
      'tenant_id': tenant_id,
      'start_date': start_date,
      'end_date': end_date,
      'rent_id': rent_id,
      'status': status,
      'currency': currency,
      'amount': amount,
      'type': type,
      'house_id': house_id,
      'parentId': parentId,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] as dynamic,
      invoice_no: map['invoice_no'] as String,
      invoice_id: map['invoice_id'] as dynamic,
      tenant_id: map['tenant_id'] as dynamic,
      start_date: map['start_date'] as dynamic,
      end_date: map['end_date'] as String,
      rent_id: map['rent_id'] as dynamic,
      status: map['status'] as dynamic,
      currency: map['currency'] as dynamic,
      amount: map['amount'] as String,
      type: map['type'] as String,
      house_id: map['house_id'] as dynamic,
      parentId: map['parentId'] as dynamic,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) => InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(id: $id, invoice_no: $invoice_no, invoice_id: $invoice_id, tenant_id: $tenant_id, start_date: $start_date, end_date: $end_date, rent_id: $rent_id, status: $status, currency: $currency, amount: $amount, type: $type, house_id: $house_id, parentId: $parentId, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.invoice_no == invoice_no &&
      other.invoice_id == invoice_id &&
      other.tenant_id == tenant_id &&
      other.start_date == start_date &&
      other.end_date == end_date &&
      other.rent_id == rent_id &&
      other.status == status &&
      other.currency == currency &&
      other.amount == amount &&
      other.type == type &&
      other.house_id == house_id &&
      other.parentId == parentId &&
      other.created_at == created_at &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      invoice_no.hashCode ^
      invoice_id.hashCode ^
      tenant_id.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      rent_id.hashCode ^
      status.hashCode ^
      currency.hashCode ^
      amount.hashCode ^
      type.hashCode ^
      house_id.hashCode ^
      parentId.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;
  }
}
