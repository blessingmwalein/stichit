import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:orders_repository/src/models/order.dart';

class OrdersRepositoryBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addOrder(CustomerOrder order, ImageFile? image) async {
    // Add order to database

    try {
      DocumentReference rugRef =
          await _firestore.collection('orders').add(order.toFirestore());

      // order.imageUrl = this._uploadImage(image, rugRef.id)
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add order: ${e.toString()}');
    }
  }

  Future<void> removeOrder(CustomerOrder order) async {
    // Remove order from database
    try {
      await _firestore.collection('orders').doc(order.id).delete();
      // Optionally, remove associated rugSizes from Firebase Storage
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove order: ${e.toString()}');
    }
  }

  Future<List<CustomerOrder>> getOrders() async {
    // Get orders from database
    try {
      final snapshot = await _firestore.collection('orders').get();
      return snapshot.docs
          .map((doc) => CustomerOrder.fromFirestore(doc))
          .toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get orders: ${e.toString()}');
    }
  }

  Future<void> updateOrder(CustomerOrder order) async {
    // Update order in database
    try {
      await _firestore
          .collection('orders')
          .doc(order.id)
          .update(order.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update order: ${e.toString()}');
    }
  }

  Future<String> _uploadImage(ImageFile image, String orderId) async {
    try {
      Reference storageRef = _storage
          .ref()
          .child('orders')
          .child('/$orderId')
          .child('/${image.name}');
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
}
