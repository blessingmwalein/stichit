import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';

part 'stock_cubit_state.dart';

class StockCubit extends Cubit<StockCubitState> {
  StockCubit({
    required StockRepository stockRepository,
  })  : _stockRepository = stockRepository,
        super(StockCubitState());

  final StockRepository _stockRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedStock = state.rawMaterialForm.copyWithField(field, value);
    log("updatedStock: $updatedStock");
    emit(state.copyWith(rawMaterialForm: updatedStock));
  }

  // Save stock
  void saveStock() {
    final rawMaterialForm = state.rawMaterialForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    //check is isedit
    if (state.isEditing) {
      _stockRepository.updateStock(rawMaterialForm).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "RawMaterial updated successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
      return;
    } else {
      _stockRepository.addStock(rawMaterialForm).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "RawMaterial saved successfully"));
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
  void editStock(RawMaterial stock) {
    emit(state.copyWith(
      rawMaterialForm: stock,
      isEditing: true,
      selectedStock: stock,
    ));
  }

  // Set selected stock
  void setSelectedStock(RawMaterial stock) {
    emit(state.copyWith(
      selectedStock: stock,
      rawMaterialForm: stock,
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
  List<RawMaterial> searchStockByCategory(String category) {
    final stocks = state.stocks;
    return stocks.where((stock) => stock.rawMaterialCategory == category).toList();
  }

  //clearForm
  void clearForm() {
    emit(state.copyWith(
      rawMaterialForm: RawMaterial.empty(),
      isEditing: false,
      selectedStock: null,
    ));
  }
}
