import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';

class Supplier extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final RawMaterialCategory rawMaterialCategory;

  const Supplier({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.rawMaterialCategory,
  });

  // from firestore
  factory Supplier.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return Supplier(
      id: snapshot.id,
      name: data['name'],
      phoneNumber: data['phone_number'],
      email: data['email'],
      address: data['address'],
      rawMaterialCategory: data['category'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': rawMaterialCategory,
    };
  }

  // CopyWith method to update a specific field
  Supplier copyWithField(String field, dynamic value) {
    switch (field) {
      case 'name':
        return copyWith(name: value);
      case 'measureType':
        return copyWith(measureType: value);
      case 'category':
        return copyWith(rawMaterialCategory: value);
      default:
        return this;
    }
  }

  factory Supplier.empty() {
    return Supplier(
      id: '',
      name: '',
      phoneNumber: '',
      email: '',
      address: '',
      // Default value for MeasureType
      rawMaterialCategory: RawMaterialCategory(),
      // Default value for RawMaterialCategory
    );
  }
  // CopyWith method
  Supplier copyWith({
    String? id,
    String? description,
    String? name,
    MeasureType? measureType,
    RawMaterialCategory? rawMaterialCategory,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      rawMaterialCategory: rawMaterialCategory ?? this.rawMaterialCategory,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        email,
        address,
        rawMaterialCategory,
      ];
}
