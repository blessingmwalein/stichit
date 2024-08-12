part of 'customer_cubit.dart';

class CustomerState extends Equatable {
  CustomerState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.pageStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    UserModel? customerForm,
    this.customers = const [],
    this.isEditing = false,
    this.selectedCustomer,
  }) : customerForm = customerForm ?? UserModel.empty;

  final FormzSubmissionStatus formStatus;
  final FormzSubmissionStatus pageStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final UserModel customerForm;
  final bool isEditing;
  final List<UserModel> customers;
  final UserModel? selectedCustomer;

  CustomerState copyWith({
    FormzSubmissionStatus? formStatus,
    FormzSubmissionStatus? pageStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    UserModel? customerForm,
    bool? isEditing,
    List<UserModel>? customers,
    UserModel? selectedCustomer,
  }) {
    return CustomerState(
      formStatus: formStatus ?? this.formStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      customerForm: customerForm ?? this.customerForm,
      isEditing: isEditing ?? this.isEditing,
      customers: customers ?? this.customers,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        pageStatus,
        isFormValid,
        errorMessage,
        successMessage,
        customerForm,
        isEditing,
        customers,
        selectedCustomer,
      ];
}
