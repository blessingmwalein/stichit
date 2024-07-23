import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_repository/src/models/stock.dart';
import 'package:stock_repository/src/models/stock_batch.dart';
import 'dart:developer';

class StockRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addStock(Stock stock) async {
    // Add stock to database
    try {
      await _firestore.collection('stocks').add(stock.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add stock: ${e.toString()}');
    }
  }

  Future<void> removeStock(Stock stock) async {
    // Remove stock from database
    try {
      await _firestore.collection('stocks').doc(stock.id).delete();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove stock: ${e.toString()}');
    }
  }

  Future<List<Stock>> getStocks() async {
    // Get stocks from database
    try {
      final snapshot = await _firestore.collection('stocks').get();
      return snapshot.docs.map((doc) => Stock.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get stocks: ${e.toString()}');
    }
  }

  Future<void> updateStock(Stock stock) async {
    // Update stock in database
    try {
      await _firestore
          .collection('stocks')
          .doc(stock.id)
          .update(stock.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update stock: ${e.toString()}');
    }
  }

  Future<void> addStockBatch(StockBatch stock) async {
    // Add stock batch to database
    try {
      await _firestore.collection('stock_batches').add(stock.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to add stock batch: ${e.toString()}');
    }
  }

  Future<void> removeStockBatch(StockBatch stock) async {
    // Remove stock batch from database
    try {
      await _firestore.collection('stock_batches').doc(stock.id).delete();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to remove stock batch: ${e.toString()}');
    }
  }

  Future<List<StockBatch>> getStockBatches() async {
    // Get stock batches from database
    try {
      final snapshot = await _firestore.collection('stock_batches').get();
      return snapshot.docs.map((doc) => StockBatch.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get stock batches: ${e.toString()}');
    }
  }

  Future<void> updateStockBatch(StockBatch stock) async {
    // Update stock batch in database
    try {
      await _firestore
          .collection('stock_batches')
          .doc(stock.id)
          .update(stock.toFirestore());
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to update stock batch: ${e.toString()}');
    }
  }

  //get stocks by batch number
  Future<List<Stock>> getStocksByBatchNumber(String batchNumber) async {
    // Get stocks from database
    try {
      final snapshot = await _firestore
          .collection('stocks')
          .where('batch_number', isEqualTo: batchNumber)
          .get();
      return snapshot.docs.map((doc) => Stock.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get stocks: ${e.toString()}');
    }
  }

  //getStocksByCategory
  Future<List<Stock>> getStocksByCategory(String category) async {
    // Get stocks from database
    try {
      final snapshot = await _firestore
          .collection('stocks')
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs.map((doc) => Stock.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get stocks: ${e.toString()}');
    }
  }

  //get all stock
  Future<List<Stock>> getAllStocks() async {
    // Get stocks from database
    try {
      final snapshot = await _firestore.collection('stocks').get();
      return snapshot.docs.map((doc) => Stock.fromFirestore(doc)).toList();
    } catch (e) {
      log('data: $e');
      throw Exception('Failed to get stocks: ${e.toString()}');
    }
  }

}
