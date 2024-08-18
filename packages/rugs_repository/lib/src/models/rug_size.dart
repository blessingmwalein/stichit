import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RugSize {
  static const String small = 'Small';
  static const String medium = 'Medium';
  static const String large = 'Large';

  static const List<String> values = [small, medium, large];

  static String fromString(String name) {
    return values.firstWhere(
      (type) => type == name,
      orElse: () => throw ArgumentError('Unknown Rug Size: $name'),
    );
  }
}

class RugSizes extends Equatable {
  final String id;
  final String rugId;
  final double length;
  final double width;
  final double price;

  const RugSizes({
    required this.id,
    required this.rugId,
    required this.length,
    required this.width,
    required this.price,
  });

  // from firestore
  factory RugSizes.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return RugSizes(
      id: snapshot.id,
      rugId: data['rug_id'],
      length: data['length'],
      width: data['width'],
      price: data['price'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'rug_id': rugId,
      'length': length,
      'width': width,
      'price': price,
    };
  }

  //copy with
  RugSizes copyWith({
    String? id,
    String? rugId,
    double? length,
    double? width,
    double? price,
  }) {
    return RugSizes(
      id: id ?? this.id,
      rugId: rugId ?? this.rugId,
      length: length ?? this.length,
      width: width ?? this.width,
      price: price ?? this.price,
    );
  }

  //empty
  static RugSizes empty = const RugSizes(
    id: '',
    rugId: '',
    length: 0.0,
    width: 0.0,
    price: 0.0,
  );

  @override
  List<Object?> get props => [id, length, width, price, rugId];
}
