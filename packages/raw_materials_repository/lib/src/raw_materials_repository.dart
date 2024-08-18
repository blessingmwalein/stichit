import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';
import 'package:raw_materials_repository/src/models/stock_batch.dart';
import 'dart:developer';

class RawMaterialsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addRawMaterial(RawMaterial rawMaterial) async {
    // Add rawMaterial to database
    try {
      await _firestore
          .collection('raw_materials')
          .add(rawMaterial.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add raw material: ${e.toString()}');
    }
  }

  Future<void> removeRawMaterial(RawMaterial rawMaterial) async {
    // Remove rawMaterial from database
    try {
      await _firestore.collection('raw_materials').doc(rawMaterial.id).delete();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove raw material: ${e.toString()}');
    }
  }

  Future<List<RawMaterial>> getRawMaterilas() async {
    // Get rawMaterials from database
    try {
      final snapshot = await _firestore.collection('raw_materials').get();
      return snapshot.docs
          .map((doc) => RawMaterial.fromFirestore(doc))
          .toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rawMaterials: ${e.toString()}');
    }
  }

  Future<void> updateRawMaterials(RawMaterial rawMaterial) async {
    // Update rawMaterial in database
    try {
      await _firestore
          .collection('raw_materials')
          .doc(rawMaterial.id)
          .update(rawMaterial.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update rawMaterial: ${e.toString()}');
    }
  }

  Future<void> addStockBatch(StockBatch rawMaterial) async {
    // Add rawMaterial batch to database
    try {
      await _firestore
          .collection('stock_batches')
          .add(rawMaterial.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add rawMaterial batch: ${e.toString()}');
    }
  }

  Future<void> removeStockBatch(StockBatch rawMaterial) async {
    // Remove rawMaterial batch from database
    try {
      await _firestore.collection('stock_batches').doc(rawMaterial.id).delete();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove rawMaterial batch: ${e.toString()}');
    }
  }

  Future<List<StockBatch>> getStockBatches() async {
    // Get rawMaterial batches from database
    try {
      final snapshot = await _firestore.collection('stock_batches').get();
      return snapshot.docs.map((doc) => StockBatch.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rawMaterial batches: ${e.toString()}');
    }
  }

  Future<void> updateStockBatch(StockBatch rawMaterial) async {
    // Update rawMaterial batch in database
    try {
      await _firestore
          .collection('stock_batches')
          .doc(rawMaterial.id)
          .update(rawMaterial.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update rawMaterial batch: ${e.toString()}');
    }
  }

  //get rawMaterials by batch number
  Future<List<RawMaterial>> getStocksByBatchNumber(String batchNumber) async {
    // Get rawMaterials from database
    try {
      final snapshot = await _firestore
          .collection('rawMaterials')
          .where('batch_number', isEqualTo: batchNumber)
          .get();
      return snapshot.docs
          .map((doc) => RawMaterial.fromFirestore(doc))
          .toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rawMaterials: ${e.toString()}');
    }
  }

  //getRawMaterialByCategory
  Future<List<RawMaterial>> getRawMaterialByCategory(String category) async {
    // Get rawMaterials from database
    try {
      final snapshot = await _firestore
          .collection('raw_materials')
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs
          .map((doc) => RawMaterial.fromFirestore(doc))
          .toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get rawMaterials: ${e.toString()}');
    }
  }

  //get all rawMaterial
  Future<List<RawMaterial>> getAllStocks() async {
    // Get rawMaterials from database
    try {
      final snapshot = await _firestore.collection('raw_materials').get();
      return snapshot.docs
          .map((doc) => RawMaterial.fromFirestore(doc))
          .toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get raw materials: ${e.toString()}');
    }
  }
}
