import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StockBatch extends Equatable {
  final String id;
  final String name;
  final String batchNumber;
  final int quantity;
  final double? total;
  final List<String>? colors;
  final String? createdAt;


  const StockBatch({
    required this.id,
    required this.name,
    required this.batchNumber,
    required this.quantity,
    this.total,
    this.colors,
    this.createdAt,
  });

  //from firestore
  factory StockBatch.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return StockBatch(
      id: snapshot.id,
      name: data['name'],
      batchNumber: data['batch_number'],
      quantity: data['quantity'],
      total: data['total'],
      colors: data['colors'],
      createdAt: data['created_att'],
    );
  }

  //to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'batch_number': batchNumber,
      'quantity': quantity,
      'total': total,
      'colors': colors,
      'created_at': createdAt,
    };
  }

  @override
  List<Object> get props => [
    id,
    name,
    batchNumber,
    quantity,
    total ?? 0,
    colors ?? [],
    createdAt ?? '',
      ];
}
