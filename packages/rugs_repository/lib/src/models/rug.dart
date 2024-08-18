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
  final double approxPricePerUnit;
  final List<RugSizes>? sizes;
  final double? approxHoursComplete;

  Rug(
      {required this.id,
      required this.name,
      required this.description,
      required this.approxPricePerUnit,
      this.sizes,
      this.approxHoursComplete});

  // from firestore
  factory Rug.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Rug(
        id: snapshot.id,
        name: data['name'],
        description: data['description'],
        approxPricePerUnit: _toDouble(data['approx_price_per_unit']),
        approxHoursComplete: _toDouble(data['approx_hours_complete']));
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
      'approx_price_per_unit': approxPricePerUnit,
      'appox_hours_complete': approxHoursComplete
    };
  }

  // copy with
  Rug copyWith(
      {String? id,
      String? name,
      String? description,
      double? approxPricePerUnit,
      double? approxHoursComplete}) {
    return Rug(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        approxPricePerUnit: approxPricePerUnit ?? this.approxPricePerUnit,
        approxHoursComplete: approxPricePerUnit ?? this.approxHoursComplete);
  }

  // empty
  static Rug empty = Rug(
      id: '',
      name: '',
      description: '',
      approxPricePerUnit: 0.0,
      approxHoursComplete: 0.0);

  // copyWithField
  Rug copyWithField(String field, dynamic value) {
    switch (field) {
      case 'name':
        return copyWith(name: value);
      case 'description':
        return copyWith(description: value);
      case 'approxPricePerUnit':
        return copyWith(approxPricePerUnit: value);
      case 'appoxHoursComplete':
        return copyWith(approxHoursComplete: approxHoursComplete);
      default:
        return this;
    }
  }

  @override
  List<Object?> get props =>
      [id, name, description, approxPricePerUnit, approxHoursComplete];
}
