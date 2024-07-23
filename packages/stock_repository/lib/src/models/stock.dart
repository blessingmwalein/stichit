import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_repository/src/models/measure_type.dart';
import 'package:stock_repository/src/models/stock_category.dart';

class Stock extends Equatable {
  final String id;
  final String description;
  final String name;
  final double price;
  final String? batchNumber;
  final String measureType;
  final double measureValue;
  final int quantity;
  final String category;
  final String? imageUrl;
  final String? color;

  Stock({
    required this.id,
    required this.description,
    required this.name,
    required this.price,
    this.batchNumber,
    required this.measureType,
    required this.measureValue,
    required this.quantity,
    required this.category,
    this.imageUrl,
    this.color,
  });

  // from firestore
  factory Stock.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return Stock(
      id: snapshot.id,
      description: data['description'],
      name: data['name'],
      price: data['price'],
      batchNumber: data['batch_number'],
      measureType: data['measure_type'],
      measureValue: data['measure_value'],
      quantity: data['quantity'],
      category: data['category'],
      imageUrl: data['imageUrl'],
      color: data['color'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'name': name,
      'price': price,
      'batch_number': batchNumber,
      'measure_type': measureType,
      'measure_value': measureValue,
      'quantity': quantity,
      'category': category,
      'imageUrl': imageUrl,
      'color': color,
    };
  }

  // CopyWith method to update a specific field
  Stock copyWithField(String field, dynamic value) {
    switch (field) {
      case 'description':
        return copyWith(description: value);
      case 'name':
        return copyWith(name: value);
      case 'price':
        return copyWith(price: value);
      case 'batchNumber':
        return copyWith(batchNumber: value);
      case 'measureType':
        return copyWith(measureType: value);
      case 'measureValue':
        return copyWith(measureValue: value);
      case 'quantity':
        return copyWith(quantity: value);
      case 'category':
        return copyWith(category: value);
      case 'imageUrl':
        return copyWith(imageUrl: value);
      case 'color':
        return copyWith(color: value);
      default:
        return this;
    }
  }

   factory Stock.empty() {
    return Stock(
      id: '',
      description: '',
      name: '',
      price: 0.0,
      measureType: MeasureType.metres, // Default value for MeasureType
      measureValue: 0.0,
      quantity: 0,
      category: StockCategory.yarn, // Default value for StockCategory
    );
  }
  // CopyWith method
  Stock copyWith({
    String? id,
    String? description,
    String? name,
    double? price,
    String? batchNumber,
    String? measureType,
    double? measureValue,
    int? quantity,
    String? category,
    String? imageUrl,
    String? color,
  }) {
    return Stock(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name,
      price: price ?? this.price,
      batchNumber: batchNumber ?? this.batchNumber,
      measureType: measureType ?? this.measureType,
      measureValue: measureValue ?? this.measureValue,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
        name,
        price,
        batchNumber,
        measureType,
        measureValue,
        quantity,
        category,
        imageUrl,
        color,
      ];
}
