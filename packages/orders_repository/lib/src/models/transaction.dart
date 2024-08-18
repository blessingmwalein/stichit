import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:orders_repository/src/models/transaction_status.dart';

class Transaction extends Equatable {
  final String id;
  final String orderId;
  final double amount;
  final TransactionStatus status;
  final String? receiptUrl;
  final String createdAt;

  const Transaction({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.status,
    this.receiptUrl,
    required this.createdAt,
  });

  // from firestore
  factory Transaction.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Transaction(
        id: snapshot.id,
        orderId: data['order_id'],
        amount: data['amount'],
        status: data['status'],
        receiptUrl: data['receipt_url'],
        createdAt: data['created_at']);
  }
  static double _toDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      return 0.0;
    }
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'order_id': orderId,
      'amount': amount,
      'status': status,
      'receipt_url': receiptUrl,
      'created_at': createdAt
    };
  }

  // copy with
  Transaction copyWith({
    String? id,
    String? orderId,
    double? amount,
    TransactionStatus? status,
    String? receptUrl,
    String? createdAt,
  }) {
    return Transaction(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        receiptUrl: receptUrl ?? this.receiptUrl,
        createdAt: createdAt ?? this.createdAt);
  }

  // empty
  static Transaction empty = Transaction(
      id: '',
      orderId: '',
      amount: 0.0,
      status: TransactionStatus.fromString('Created'),
      receiptUrl: '',
      createdAt: '');

  // copyWithField
  Transaction copyWithField(String field, dynamic value) {
    switch (field) {
      case 'orderId':
        return copyWith(orderId: value);
      case 'amount':
        return copyWith(amount: value);
      case 'status':
        return copyWith(status: value);
      case 'createdAt':
        return copyWith(createdAt: value);
      case 'receiptUrl':
        return copyWith(receptUrl: value);
      default:
        return this;
    }
  }

  @override
  List<Object?> get props =>
      [id, orderId, amount, status, receiptUrl, createdAt];
}
