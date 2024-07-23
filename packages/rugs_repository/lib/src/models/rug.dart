import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:rugs_repository/src/models/rug_measure_type.dart';
import 'package:rugs_repository/src/models/rug_shape.dart';
import 'package:rugs_repository/src/models/rug_type.dart';

class Rug extends Equatable {
  final String id;
  final String name;
  final String description;
  final double pricePerUnit;
  final String measureType;
  final double measureValue;
  final String type;
  final String shape;
  final List<RugImage>? images;

  Rug({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerUnit,
    required this.measureType,
    required this.measureValue,
    required this.type,
    required this.shape,
    this.images,
  });

  // from firestore
  factory Rug.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Rug(
      id: snapshot.id,
      name: data['name'],
      description: data['description'],
      pricePerUnit: data['price_per_unit'],
      measureType: data['measure_type'] ?? RugMeasureType.lw,
      measureValue: data['measure_value'],
      type: RugType.fromString(data['type']),
      shape: data['shape'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price_per_unit': pricePerUnit,
      'measure_type': measureType,
      'measure_value': measureValue,
      'type': type,
      'shape': shape,
    };
  }

  // copy with
  Rug copyWith({
    String? id,
    String? name,
    String? description,
    double? pricePerUnit,
    String? measureType,
    double? measureValue,
    String? type,
    String? shape,
    List<String>? colors,
  }) {
    return Rug(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      measureType: measureType ?? this.measureType,
      measureValue: measureValue ?? this.measureValue,
      type: type ?? this.type,
      shape: shape ?? this.shape,
    );
  }

  // empty
  static Rug empty = Rug(
      id: '',
      name: '',
      description: '',
      pricePerUnit: 0.0,
      measureType: RugMeasureType.lw,
      measureValue: 0.0,
      type: RugType.cutPile,
      shape: RugShape.rectangle);

  // copyWithField
  Rug copyWithField(String field, dynamic value) {
    switch (field) {
      case 'name':
        return copyWith(name: value);
      case 'description':
        return copyWith(description: value);
      case 'pricePerUnit':
        return copyWith(pricePerUnit: value);
      case 'measureType':
        return copyWith(measureType: value);
      case 'measureValue':
        return copyWith(measureValue: value);
      case 'type':
        return copyWith(type: RugType.fromString(value) ?? type);
      case 'shape':
        return copyWith(shape: RugShape.fromString(value));
      default:
        return this;
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pricePerUnit,
        measureType,
        measureValue,
        type,
        shape,
      ];
}
