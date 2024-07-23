import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RugImage extends Equatable {
  final String id;
  final String rugId;
  final String? caption;
  final String imageUrl;

  const RugImage({
    required this.id,
    required this.rugId,
    this.caption,
    required this.imageUrl,
  });

  // from firestore
  factory RugImage.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return RugImage(
      id: snapshot.id,
      rugId: data['rug_id'],
      caption: data[' caption'],
      imageUrl: data['image_url'],
    );
  }

  // to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'rug_id': rugId,
      'caption': caption,
      'image_url': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id, caption, imageUrl, rugId];
}
