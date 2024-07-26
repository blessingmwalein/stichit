import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:rugs_repository/src/models/rug.dart';
import 'package:rugs_repository/src/models/rug_image.dart';

class RugsRepositoryBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addRug(Rug rug, List<ImageFile>? images) async {
    // Add rug to database
    try {
      DocumentReference rugRef =
          await _firestore.collection('rugs').add(rug.toFirestore());

      if (images != null && images.isNotEmpty) {
        for (var image in images) {
          String imageUrl = await _uploadImage(image, rugRef.id);
          await _addRugImageRecord(rugRef.id, imageUrl, image.name);
        }
      }
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add rug: ${e.toString()}');
    }
  }

  Future<void> removeRug(Rug rug) async {
    // Remove rug from database
    try {
      await _firestore.collection('rugs').doc(rug.id).delete();
      // Optionally, remove associated images from Firebase Storage
      await _removeRugImages(rug.id);
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove rug: ${e.toString()}');
    }
  }

  Future<List<Rug>> getRugs() async {
    // Get rugs from database
    try {
      final snapshot = await _firestore.collection('rugs').get();
      return snapshot.docs.map((doc) => Rug.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rugs: ${e.toString()}');
    }
  }

  Future<void> updateRug(Rug rug, List<ImageFile>? images) async {
    // Update rug in database
    try {
      await _firestore.collection('rugs').doc(rug.id).update(rug.toFirestore());

      if (images != null && images.isNotEmpty) {
        // Remove current images for the rug
        await _removeRugImages(rug.id);

        // Upload new images and add records
        for (var image in images) {
          String imageUrl = await _uploadImage(image, rug.id);
          await _addRugImageRecord(rug.id, imageUrl, image.name);
        }
      }
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update rug: ${e.toString()}');
    }
  }

  Future<void> _removeRugImages(String rugId) async {
    try {
      final snapshot = await _firestore
          .collection('rug_images')
          .where('rug_id', isEqualTo: rugId)
          .get();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final imageUrl = data['image_url'] as String;

        // Delete image from Firebase Storage
        final storageRef = _storage.refFromURL(imageUrl);
        await storageRef.delete();

        // Delete image record from Firestore
        await doc.reference.delete();
      }
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove rug images: ${e.toString()}');
    }
  }

  Future<String> _uploadImage(ImageFile image, String rugId) async {
    try {
      Reference storageRef =
          _storage.ref().child('rugs').child('/$rugId').child('/${image.name}');
      UploadTask uploadTask = storageRef.putFile(
          File(image.path!),
          SettableMetadata(
            contentType: 'image/jpeg',
          ));

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }

  Future<void> _addRugImageRecord(
      String rugId, String imageUrl, String caption) async {
    try {
      final rugImage = RugImage(
        id: '', // Firestore will auto-generate an ID
        rugId: rugId,
        caption: caption,
        imageUrl: imageUrl,
      );

      await _firestore.collection('rug_images').add(rugImage.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add rug image record: ${e.toString()}');
    }
  }

  Future<List<RugImage>> getRugImages(String rugId) async {
    try {
      final snapshot = await _firestore
          .collection('rug_images')
          .where('rug_id', isEqualTo: rugId)
          .get();
      return snapshot.docs.map((doc) => RugImage.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rug images: ${e.toString()}');
    }
  }
}
