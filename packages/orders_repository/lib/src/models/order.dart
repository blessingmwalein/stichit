import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:orders_repository/src/models/order_image.dart';
import 'package:orders_repository/src/models/order_status.dart';

import 'package:rugs_repository/rugs_repository.dart';
import 'package:ui_commons/formatter.dart';

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
  final double deposit;
  final double totalCost;
  final String? estimatedDeliveryDate;
  final int? orderNumber;
  final bool? orderConfirmed;

  // Add relationships as optional fields
  final Rug? rug;
  final RugSizes? rugSize;
  final UserModel? user;
  final OrderImage? orderImage;

  const CustomerOrder(
      {required this.id,
      required this.userId,
      required this.rugId,
      required this.rugSizeId,
      required this.imageUrl,
      this.colorPalet,
      required this.createdAt,
      required this.status,
      required this.deposit,
      required this.totalCost,
      this.estimatedDeliveryDate,
      this.notes,
      this.rug,
      this.rugSize,
      this.user,
      this.orderImage,
      this.orderConfirmed,
      required this.orderNumber});

  // from Firestore
  factory CustomerOrder.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      Rug? rug,
      RugSizes? rugSize,
      UserModel? user,
      OrderImage? orderImage) {
    final data = snapshot.data()!;
    return CustomerOrder(
        id: snapshot.id,
        userId: data['user_id'],
        rugId: data['rug_id'],
        rugSizeId: data['rug_size_id'],
        imageUrl: data['image_url'],
        colorPalet: data['color_palet'] != null
            ? List<String>.from(data['color_palet'])
            : null,
        createdAt: DateFormatter.formatDateString(data['created_at'],
            includeTime: true),
        status: OrderStatus.fromString(data['status']),
        deposit: _toDouble(data['deposit']),
        totalCost: _toDouble(data['total_cost']),
        estimatedDeliveryDate: data['estimated_delivery_date'],
        rug: rug,
        rugSize: rugSize,
        user: user,
        orderImage: orderImage,
        notes: data['notes'],
        orderConfirmed: data['order_confirmation'],
        orderNumber: data['order_number']);
  }

  // Fetch relationships
  Future<CustomerOrder> fetchRelatedData() async {
    final rugSnapshot =
        await FirebaseFirestore.instance.collection('rugs').doc(rugId).get();
    final rugSizeSnapshot = await FirebaseFirestore.instance
        .collection('rug_sizes')
        .doc(rugSizeId)
        .get();
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Fetch the OrderImage related to this order
    final orderImageSnapshot = await FirebaseFirestore.instance
        .collection('order_images')
        .where('order_id', isEqualTo: id)
        .get();

    return CustomerOrder(
        id: id,
        userId: userId,
        rugId: rugId,
        rugSizeId: rugSizeId,
        imageUrl: imageUrl,
        colorPalet: colorPalet,
        createdAt: createdAt,
        status: status,
        deposit: deposit,
        totalCost: totalCost,
        estimatedDeliveryDate: estimatedDeliveryDate,
        notes: notes,
        orderConfirmed: orderConfirmed,
        rug: Rug.fromFirestore(rugSnapshot),
        rugSize: RugSizes.fromFirestore(rugSizeSnapshot),
        user: UserModel.fromFirestore(userSnapshot),
        orderImage: orderImageSnapshot.docs.isNotEmpty
            ? OrderImage.fromFirestore(orderImageSnapshot.docs.first)
            : null,
        orderNumber: orderNumber);
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

  // to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'user_id': userId,
      'rug_id': rugId,
      'rug_size_id': rugSizeId,
      'image_url': imageUrl,
      'color_palet': colorPalet,
      'created_at': createdAt,
      'status': status.name,
      'notes': notes,
      'deposit': deposit,
      'total_cost': totalCost,
      'estimated_delivery_date': estimatedDeliveryDate,
      'order_number': orderNumber
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
      String? notes,
      List<String>? colorPalet,
      Rug? rug,
      RugSizes? rugSize,
      OrderImage? orderImage,
      UserModel? user,
      bool? orderConfirmed,
      int? orderNumber}) {
    return CustomerOrder(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        rugId: rugId ?? this.rugId,
        rugSizeId: rugSizeId ?? this.rugSizeId,
        imageUrl: imageUrl ?? this.imageUrl,
        notes: notes ?? this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        colorPalet: colorPalet ?? this.colorPalet,
        deposit: deposit ?? this.deposit,
        totalCost: totalCost ?? this.totalCost,
        estimatedDeliveryDate:
            estimatedDeliveryDate ?? this.estimatedDeliveryDate,
        rug: rug ?? this.rug,
        rugSize: rugSize ?? this.rugSize,
        user: user ?? this.user,
        orderConfirmed: orderConfirmed ?? this.orderConfirmed,
        orderNumber: orderNumber ?? this.orderNumber,
        orderImage: orderImage ?? this.orderImage);
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
      notes: '',
      colorPalet: [],
      rug: null,
      rugSize: null,
      deposit: 0,
      user: null,
      orderConfirmed: false,
      orderNumber: 0);

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
        return copyWith(imageUrl: value);
      case 'notes':
        return copyWith(notes: value);
      case 'status':
        return copyWith(status: value);
      case 'deposit':
        return copyWith(deposit: value);
      case 'totalCost':
        return copyWith(totalCost: value);
      case 'estimatedDeliveryDate':
        return copyWith(estimatedDeliveryDate: value);
      case 'colorPalet':
        return copyWith(colorPalet: List<String>.from(value));
      case 'rug':
        return copyWith(rug: value);
      case 'rugSize':
        return copyWith(rugSize: value);
      case 'user':
        return copyWith(user: value);
      case 'orderNumber':
        return copyWith(orderNumber: orderNumber);
      default:
        return this;
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        rugId,
        rugSizeId,
        createdAt,
        imageUrl,
        notes,
        status,
        colorPalet,
        deposit,
        totalCost,
        estimatedDeliveryDate,
        rug,
        rugSize,
        user,
        orderNumber,
        orderImage
      ];
}
