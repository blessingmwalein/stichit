import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderImage extends Equatable {
  final String id;
  final String orderId;
  final String? caption;
  final String imageUrl;

  const OrderImage({
    required this.id,
    required this.orderId,
    this.caption,
    required this.imageUrl,
  });

  // from firestore
  factory OrderImage.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return OrderImage(
      id: snapshot.id,
      orderId: data['order_id'],
      caption: data[' caption'],
      imageUrl: data['image_url'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'order_id': orderId,
      'caption': caption,
      'image_url': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id, caption, imageUrl, orderId];
}
