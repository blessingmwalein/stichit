import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';

class RawMaterialItem extends Equatable {
  final String id;
  final String description;
  final String name;
  final MeasureType measureType;
  final RawMaterialCategory rawMaterialCategory;

  const RawMaterialItem({
    required this.id,
    required this.description,
    required this.name,
    required this.measureType,
    required this.rawMaterialCategory,
  });

  // from firestore
  factory RawMaterialItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return RawMaterialItem(
      id: snapshot.id,
      description: data['description'],
      name: data['name'],
      measureType: data['measure_type'],
      rawMaterialCategory: data['category'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'name': name,
      'measure_type': measureType,
      'category': rawMaterialCategory,
    };
  }

  // CopyWith method to update a specific field
  RawMaterialItem copyWithField(String field, dynamic value) {
    switch (field) {
      case 'description':
        return copyWith(description: value);
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

  factory RawMaterialItem.empty() {
    return RawMaterialItem(
      id: '',
      description: '',
      name: '',
      measureType: MeasureType(),
      // Default value for MeasureType
      rawMaterialCategory: RawMaterialCategory(),
      // Default value for RawMaterialCategory
    );
  }
  // CopyWith method
  RawMaterialItem copyWith({
    String? id,
    String? description,
    String? name,
    MeasureType? measureType,
    RawMaterialCategory? rawMaterialCategory,
  }) {
    return RawMaterialItem(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name,
      measureType: measureType ?? this.measureType,
      rawMaterialCategory: rawMaterialCategory ?? this.rawMaterialCategory,
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
        name,
        measureType,
        rawMaterialCategory,
      ];
}
