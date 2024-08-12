import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit({
    required CustomerRepository customerRepository,
  })  : _customerRepository = customerRepository,
        super(CustomerState());

  final CustomerRepository _customerRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedCustomer = state.customerForm.copyWithField(field, value);
    log("updatedCustomer: $updatedCustomer");
    emit(state.copyWith(customerForm: updatedCustomer));
  }

  // Save customer
  void saveCustomer() {
    final customerForm = state.customerForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    if (state.isEditing) {
      _customerRepository.updateUser(customerForm).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "UserModel updated successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
    } else {
      _customerRepository.addUser(customerForm).then((_) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            successMessage: "UserModel saved successfully"));
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
  void editCustomer(UserModel customer) {
    emit(state.copyWith(
      customerForm: customer,
      isEditing: true,
      selectedCustomer: customer,
    ));
  }

  // Set selected customer
  void setSelectedCustomer(UserModel customer) {
    emit(state.copyWith(
      selectedCustomer: customer,
      customerForm: customer,
    ));
  }

  // Get customers by email
  void getCustomersByEmail(String email) {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _customerRepository.getUsersByEmail(email).then((customers) {
      emit(state.copyWith(
          customers: customers, pageStatus: FormzSubmissionStatus.success));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  // Get all customers
  void getCustomers() {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _customerRepository.getCustomers().then((customers) {
      emit(state.copyWith(
          customers: customers, pageStatus: FormzSubmissionStatus.success));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  // Search customer by email from state.customers
  List<UserModel> searchCustomerByEmail(String email) {
    final customers = state.customers;
    return customers.where((customer) => customer.email == email).toList();
  }

  //clearForm
  void clearForm() {
    emit(state.copyWith(
      customerForm: UserModel.empty,
      isEditing: false,
      selectedCustomer: null,
    ));
  }
}
