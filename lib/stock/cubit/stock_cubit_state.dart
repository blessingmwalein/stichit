part of 'stock_cubit.dart';

final class StockCubitState extends Equatable {
  StockCubitState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.pageStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    Stock? stockForm,
    this.stocks = const [],
    this.isEditing = false,
    this.selectedStock,
  }) : stockForm = stockForm ?? Stock.empty();

  final FormzSubmissionStatus formStatus;
  final FormzSubmissionStatus pageStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final Stock stockForm;
  final bool isEditing;
  final List<Stock> stocks;
  final Stock? selectedStock;

  StockCubitState copyWith({
    FormzSubmissionStatus? formStatus,
    FormzSubmissionStatus? pageStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    Stock? stockForm,
    bool? isEditing,
    List<Stock>? stocks,
    Stock? selectedStock,
  }) {
    return StockCubitState(
      formStatus: formStatus ?? this.formStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      stockForm: stockForm ?? this.stockForm,
      isEditing: isEditing ?? this.isEditing,
      stocks: stocks ?? this.stocks,
      selectedStock: selectedStock ?? this.selectedStock,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        pageStatus,
        isFormValid,
        errorMessage,
        successMessage,
        stockForm,
        isEditing,
        stocks,
        selectedStock,
      ];
}
