part of 'customer_cubit.dart';

class CustomerState extends Equatable {
  CustomerState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.pageStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    UserModel? customerForm,
    CustomerOrder? orderForm,
    this.customers = const [],
    this.orders = const [],
    this.isEditing = false,
    this.selectedCustomer,
    this.selectedOrder,
    this.orderImage,
  })  : customerForm = customerForm ?? UserModel.empty,
        orderForm = orderForm ?? CustomerOrder.empty;

  final FormzSubmissionStatus formStatus;
  final FormzSubmissionStatus pageStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final UserModel customerForm;
  final bool isEditing;
  final List<UserModel> customers;
  final List<CustomerOrder> orders;
  final UserModel? selectedCustomer;
  final CustomerOrder? selectedOrder;
  final CustomerOrder orderForm;
  final XFile? orderImage;

  CustomerState copyWith({
    FormzSubmissionStatus? formStatus,
    FormzSubmissionStatus? pageStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    UserModel? customerForm,
    CustomerOrder? orderForm,
    bool? isEditing,
    List<UserModel>? customers,
    List<CustomerOrder>? orders,
    UserModel? selectedCustomer,
    CustomerOrder? selectedOrder,
    XFile? orderImage,
  }) {
    return CustomerState(
      formStatus: formStatus ?? this.formStatus,
      pageStatus: pageStatus ?? this.pageStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      customerForm: customerForm ?? this.customerForm,
      orderForm: orderForm ?? this.orderForm,
      isEditing: isEditing ?? this.isEditing,
      customers: customers ?? this.customers,
      orders: orders ?? this.orders,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      orderImage: orderImage ?? this.orderImage,
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
        orders,
        orderForm,
        selectedOrder,
        orderImage,
      ];
}
