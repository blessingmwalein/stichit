import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rugs_repository/rugs_repository.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String rugId;
  final RugSizes size;
  final int qty;
  final List<String>? images;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.rugId,
      required this.size,
      required this.qty,
      this.images});

  // from firestore
  factory Product.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Product(
        id: snapshot.id,
        name: data['name'],
        description: data['description'],
        rugId: data['rug_id'],
        qty: data['qty'],
        images: data['image_url'],
        size: data['size']);
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
      'name': name,
      'description': description,
      'rug_id': rugId,
      'size': size,
      'image_url': images
    };
  }

  // copy with
  Product copyWith(
      {String? id,
      String? name,
      String? description,
      String? rugId,
      List<String>? images,
      RugSizes? size,
      int? qty}) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        rugId: rugId ?? this.rugId,
        images: images ?? this.images,
        size: size ?? this.size,
        qty: qty ?? this.qty);
  }

  // empty
  static Product empty = Product(
      id: '',
      name: '',
      description: '',
      rugId: '',
      size: RugSizes.empty,
      images: [],
      qty: 0);

  // copyWithField
  Product copyWithField(String field, dynamic value) {
    switch (field) {
      case 'name':
        return copyWith(name: value);
      case 'description':
        return copyWith(description: value);
      case 'rugId':
        return copyWith(rugId: value);
      case 'size':
        return copyWith(size: value);
      case 'qty':
        return copyWith(qty: value);
      default:
        return this;
    }
  }

  @override
  List<Object?> get props => [id, name, description, rugId, size, qty, images];
}
