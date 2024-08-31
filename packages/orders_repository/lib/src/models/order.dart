import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:orders_repository/src/models/order_status.dart';

class CustomerOrder extends Equatable {
  final String id;
  final String userId;
  final String rugId;
  final String rugSizeId;
  final String imageUrl;
  final String createdAt;
  final List<String>? colorPalet;
  final String? notes;
  final OrderStatus status;
  final double? deposit;
  final double totalCost;
  final String? estimatedDeliveryDate;

  const CustomerOrder(
      {required this.id,
      required this.userId,
      required this.rugId,
      required this.rugSizeId,
      required this.imageUrl,
      this.colorPalet,
      required this.createdAt,
      required this.status,
      this.deposit = 0.0,
      required this.totalCost,
      this.estimatedDeliveryDate,
      required this.notes});

  // from firestore
  factory CustomerOrder.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CustomerOrder(
        id: snapshot.id,
        userId: data['user_id'],
        rugId: data['rug_id'],
        rugSizeId: data['rug_size_id'],
        imageUrl: data['image_url'],
        colorPalet: List.from(data['color_palet']),
        createdAt: data['created_at'],
        status: data['status'],
        deposit: _toDouble(data['deposit']),
        totalCost: _toDouble(data['total_cost']),
        estimatedDeliveryDate: data['estimated_delivery_date'],
        notes: data['notes']);
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
      'user_id': userId,
      'rug_id': rugId,
      'rug_size_id': rugSizeId,
      'image_url': imageUrl,
      'color_palet': colorPalet,
      'created_at': createdAt,
      'status': status,
      'notes': notes,
      'deposit': deposit,
      'total_cost': totalCost,
      'estimated_delivery_date': estimatedDeliveryDate
    };
  }

  // copy with
  CustomerOrder copyWith(
      {String? id,
      String? userId,
      String? rugId,
      String? rugSizeId,
      String? imageUrl,
      String? createdAt,
      OrderStatus? status,
      double? deposit,
      double? totalCost,
      String? estimatedDeliveryDate,
      String? notes}) {
    return CustomerOrder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      rugId: rugId ?? this.rugId,
      rugSizeId: rugSizeId ?? this.rugSizeId,
      imageUrl: imageUrl ?? this.imageUrl,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      colorPalet: colorPalet,
      deposit: deposit,
      totalCost: totalCost ?? this.totalCost,
      estimatedDeliveryDate: estimatedDeliveryDate,
    );
  }

  // empty
  static CustomerOrder empty = CustomerOrder(
      id: '',
      userId: '',
      rugId: '',
      rugSizeId: '',
      createdAt: '',
      imageUrl: '',
      status: OrderStatus.fromString('Created'),
      totalCost: 0.0,
      estimatedDeliveryDate: null,
      notes: '');

  // copyWithField
  CustomerOrder copyWithField(String field, dynamic value) {
    switch (field) {
      case 'userId':
        return copyWith(userId: value);
      case 'rugId':
        return copyWith(rugId: value);
      case 'rugSizeId':
        return copyWith(rugSizeId: value);
      case 'createdAt':
        return copyWith(createdAt: value);
      case 'imageUrl':
        return copyWith(imageUrl: imageUrl);
      case 'notes':
        return copyWith(notes: notes);
      case 'status':
        return copyWith(status: status);
      case 'deposit':
        return copyWith(deposit: value);
      case 'totalCost':
        return copyWith(totalCost: value);
      case 'estimatedDeliveryDate':
        return copyWith(estimatedDeliveryDate: value);
      default:
        return this;
    }
  }

  @override
  List<Object?> get props =>
      [id, userId, rugId, rugSizeId, createdAt, imageUrl, notes, status];
}
