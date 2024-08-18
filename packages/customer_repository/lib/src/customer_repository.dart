import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class CustomerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new user to the Firestore database
  Future<void> addUser(UserModel user) async {
    try {
      await _firestore.collection('users').add(user.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add user: ${e.toString()}');
    }
  }

  // Remove a user from the Firestore database by ID
  Future<void> removeUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove user: ${e.toString()}');
    }
  }

  // Get a list of all users from the Firestore database
  Future<List<UserModel>> getUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get users: ${e.toString()}');
    }
  }

  //get customers where is_admin is false
  Future<List<UserModel>> getCustomers() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('is_admin', isEqualTo: false)
          .get();
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get customers: ${e.toString()}');
    }
  }

  // Update an existing user's information in the Firestore database
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .update(user.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update user: ${e.toString()}');
    }
  }

  // Get a user by email address
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromFirestore(snapshot.docs.first);
      }
      return null;
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get user by email: ${e.toString()}');
    }
  }

  // Get all admins from the database
  Future<List<UserModel>> getAdmins() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('is_admin', isEqualTo: true)
          .get();
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get admins: ${e.toString()}');
    }
  }

  //get users by email
  Future<List<UserModel>> getUsersByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get users by email: ${e.toString()}');
    }
  }

  //deleteUser
  Future<void> deleteUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).delete();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to delete user: ${e.toString()}');
    }
  }
}
