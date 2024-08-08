part of 'stock_cubit.dart';

final class StockCubitState extends Equatable {
  StockCubitState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.pageStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    RawMaterial? rawMaterialForm,
    this.stocks = const [],
    this.isEditing = false,
    this.selectedStock,
  }) : rawMaterialForm = rawMaterialForm ?? RawMaterial.empty();

  final FormzSubmissionStatus formStatus;
  final FormzSubmissionStatus pageStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final RawMaterial rawMaterialForm;
  final bool isEditing;
  final List<RawMaterial> stocks;
  final RawMaterial? selectedStock;

  StockCubitState copyWith({
    FormzSubmissionStatus? formStatus,
    FormzSubmissionStatus? pageStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    RawMaterial? rawMaterialForm,
    bool? isEditing,
    List<RawMaterial>? stocks,
    RawMaterial? selectedStock,
  }) {
    return StockCubitState(
      formStatus: formStatus ?? this.formStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      rawMaterialForm: rawMaterialForm ?? this.rawMaterialForm,
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
        rawMaterialForm,
        isEditing,
        stocks,
        selectedStock,
      ];
}
