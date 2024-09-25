import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:orders_repository/src/models/order.dart';
import 'package:orders_repository/src/models/order_image.dart';
import 'package:rugs_repository/rugs_repository.dart';

class OrdersRepositoryBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addOrder(CustomerOrder order, XFile? image) async {
    try {
      // Step 1: Get the current highest order number
      int newOrderNumber = await _getNextOrderNumber();

      // Step 2: Assign the new order number to the order
      order = order.copyWith(orderNumber: newOrderNumber);

      // Step 3: Add order to the database
      DocumentReference rugRef =
          await _firestore.collection('orders').add(order.toFirestore());

      // Step 4: Upload the image and link it to the order if an image is provided
      if (image != null) {
        String imageUrl = await _uploadImage(image, rugRef.id);
        await _addOrderImageRecord(rugRef.id, imageUrl, image.name);
      }
    } catch (e) {
      log('Failed to add order: $e');
      throw Exception('Failed to add order: ${e.toString()}');
    }
  }

  Future<int> _getNextOrderNumber() async {
    try {
      // Query Firestore to get the order with the highest order number
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .orderBy('order_number', descending: true)
          .limit(1)
          .get();

      // Get the current highest order number
      if (snapshot.docs.isNotEmpty) {
        int highestOrderNumber = snapshot.docs.first['order_number'] as int;
        return highestOrderNumber + 1;
      } else {
        // If there are no orders yet, start with order number 1
        return 1;
      }
    } catch (e) {
      log('Failed to get next order number: $e');
      throw Exception('Failed to get next order number: ${e.toString()}');
    }
  }

  Future<void> _addOrderImageRecord(
      String orderId, String imageUrl, String caption) async {
    try {
      final rugImage = OrderImage(
        id: '', // Firestore will auto-generate an ID
        orderId: orderId,
        caption: caption,
        imageUrl: imageUrl,
      );

      await _firestore.collection('order_images').add(rugImage.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add order image record: ${e.toString()}');
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
    final querySnapshot =
        await FirebaseFirestore.instance.collection('orders').get();

    return await Future.wait(querySnapshot.docs.map((doc) async {
      // Fetch the Rug related to this order
      final rugDoc = await FirebaseFirestore.instance
          .collection('rugs')
          .doc(doc['rug_id'])
          .get();

      // Fetch the RugSize related to this order
      final rugSizeDoc = await FirebaseFirestore.instance
          .collection('rug_sizes')
          .doc(doc['rug_size_id'])
          .get();

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(doc['user_id'])
          .get();

      //order image doc
      final orderImageDoc = await FirebaseFirestore.instance
          .collection('order_images')
          .where('order_id', isEqualTo: doc.id)
          .get();

      final rug = rugDoc.exists ? Rug.fromFirestore(rugDoc) : null;

      final rugSize =
          rugSizeDoc.exists ? RugSizes.fromFirestore(rugSizeDoc) : null;

      final user = userDoc.exists ? UserModel.fromFirestore(userDoc) : null;

      final orderImage = orderImageDoc.docs.isNotEmpty
          ? OrderImage.fromFirestore(orderImageDoc.docs.first)
          : null;

      return CustomerOrder.fromFirestore(doc, rug, rugSize, user, orderImage);
    }).toList());
  }

  Future<void> updateOrder(CustomerOrder order, XFile? image) async {
    try {
      // Step 1: Update order in the database
      DocumentReference orderRef =
          _firestore.collection('orders').doc(order.id);

      await orderRef.update(order.toFirestore());

      // Step 2: Upload the image and link it to the order if an image is provided
      if (image != null) {
        //delete existing image
        await deleteOrderImage(order.id);
        String imageUrl = await _uploadImage(image, orderRef.id);
        await _addOrderImageRecord(orderRef.id, imageUrl, image.name);
      }
    } catch (e) {
      log('Failed to update order: $e');
      throw Exception('Failed to update order: ${e.toString()}');
    }
  }

  //delete image for order
  Future<void> deleteOrderImage(String orderId) async {
    try {
      final orderImageDoc = await FirebaseFirestore.instance
          .collection('order_images')
          .where('order_id', isEqualTo: orderId)
          .get();

      if (orderImageDoc.docs.isNotEmpty) {
        await _firestore
            .collection('order_images')
            .doc(orderImageDoc.docs.first.id)
            .delete();
      }
    } catch (e) {
      log('Failed to delete order image: $e');
      throw Exception('Failed to delete order image: ${e.toString()}');
    }
  }

  Future<String> _uploadImage(XFile image, String orderId) async {
    try {
      Reference storageRef = _storage
          .ref()
          .child('orders')
          .child('/$orderId')
          .child('/${image.name}');

      UploadTask uploadTask;

      if (kIsWeb) {
        // Web-specific implementation
        uploadTask = storageRef.putData(
          await image.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        );
      } else {
        // Other platforms (iOS, Android)
        uploadTask = storageRef.putFile(
          File(image.path),
          SettableMetadata(contentType: 'image/jpeg'),
        );
      }

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }

  //uodate order status
  Future<void> updateOrderStatus(
      {required String status, required String id}) async {
    try {
      await _firestore.collection('orders').doc(id).update({'status': status});
    } catch (e) {
      log('Failed to update order status: $e');
      throw Exception('Failed to update order status: ${e.toString()}');
    }
  }
}
