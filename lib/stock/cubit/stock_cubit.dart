import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:stock_repository/stock_repository.dart';

part 'stock_cubit_state.dart';

class StockCubit extends Cubit<StockCubitState> {
  StockCubit({
    required StockRepository stockRepository,
  })  : _stockRepository = stockRepository,
        super(StockCubitState());

  final StockRepository _stockRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedStock = state.stockForm.copyWithField(field, value);
    log("updatedStock: $updatedStock");
    emit(state.copyWith(stockForm: updatedStock));
  }

  // Save stock
  void saveStock() {
    final stockForm = state.stockForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    //check is isedit
    if (state.isEditing) {
      _stockRepository.updateStock(stockForm).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "Stock updated successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
      return;
    } else {
      _stockRepository.addStock(stockForm).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "Stock saved successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
    }
  }

  void resetFormStatus() {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }

  // Onclick edit
  void editStock(Stock stock) {
    emit(state.copyWith(
      stockForm: stock,
      isEditing: true,
      selectedStock: stock,
    ));
  }

  // Set selected stock
  void setSelectedStock(Stock stock) {
    emit(state.copyWith(
      selectedStock: stock,
      stockForm: stock,
    ));
  }

  // Get stocks by category
  void getStocksByCategory(String category) {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _stockRepository.getStocksByCategory(category).then((stocks) {
      emit(state.copyWith(
          stocks: stocks, pageStatus: FormzSubmissionStatus.success));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  // Get all stocks
  void getStocks() {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _stockRepository.getStocks().then((stocks) {
      emit(state.copyWith(
          stocks: stocks, pageStatus: FormzSubmissionStatus.success));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  // Search stock by category from state.stocks
  List<Stock> searchStockByCategory(String category) {
    final stocks = state.stocks;
    return stocks.where((stock) => stock.category == category).toList();
  }

  //clearForm
  void clearForm() {
    emit(state.copyWith(
      stockForm: Stock.empty(),
      isEditing: false,
      selectedStock: null,
    ));
  }
}
