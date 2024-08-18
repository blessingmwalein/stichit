import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:rugs_repository/src/models/rug.dart';
import 'package:rugs_repository/src/models/rug_image.dart';

class RugsRepositoryBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addRug(Rug rug, List<RugSizes>? rugSizes) async {
    // Add rug to database
    try {
      DocumentReference rugRef =
          await _firestore.collection('rugs').add(rug.toFirestore());

      if (rugSizes != null && rugSizes.isNotEmpty) {
        for (var rugSize in rugSizes) {
          RugSizes newRugSize = rugSize.copyWith(rugId: rugRef.id);
          await _addRugSizeRecord(newRugSize);
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
      // Optionally, remove associated rugSizes from Firebase Storage
      await _removeRugSizes(rug.id);
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

  Future<void> updateRug(Rug rug, List<RugSizes>? rugSizes) async {
    // Update rug in database
    try {
      await _firestore.collection('rugs').doc(rug.id).update(rug.toFirestore());

      if (rugSizes != null && rugSizes.isNotEmpty) {
        // Remove current rugSizes for the rug
        await _removeRugSizes(rug.id);

        // Upload new rugSizes and add records
        for (var rugSize in rugSizes) {
          RugSizes newRugSize = rugSize.copyWith(rugId: rug.id);
          await _addRugSizeRecord(newRugSize);
        }
      }
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update rug: ${e.toString()}');
    }
  }

  Future<void> _removeRugSizes(String rugId) async {
    try {
      final snapshot = await _firestore
          .collection('rug_sizes')
          .where('rug_id', isEqualTo: rugId)
          .get();
      for (var doc in snapshot.docs) {
        await _firestore.collection('rug_sizes').doc(doc.id).delete();
      }
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove rug rugSizes: ${e.toString()}');
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

  Future<void> _addRugSizeRecord(RugSizes rugSize) async {
    try {
      await _firestore.collection('rug_sizes').add(rugSize.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add rug image record: ${e.toString()}');
    }
  }

  Future<List<RugSizes>> getRugSizes(String rugId) async {
    try {
      final snapshot = await _firestore
          .collection('rug_sizes')
          .where('rug_id', isEqualTo: rugId)
          .get();
      return snapshot.docs.map((doc) => RugSizes.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rug rugSizes: ${e.toString()}');
    }
  }
}
