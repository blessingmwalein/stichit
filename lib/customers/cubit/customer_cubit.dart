import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:orders_repository/orders_repository.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit({
    required CustomerRepository customerRepository,
    required OrdersRepositoryBase ordersRepository,
  })  : _customerRepository = customerRepository,
        _ordersRepository = ordersRepository,
        super(CustomerState());

  final CustomerRepository _customerRepository;
  final OrdersRepositoryBase _ordersRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedCustomer = state.customerForm.copyWithField(field, value);

    emit(state.copyWith(customerForm: updatedCustomer));
  }

  void onOrderFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedOrder = state.orderForm.copyWithField(field, value);
    log("updatedOrder: $updatedOrder");
    emit(state.copyWith(orderForm: updatedOrder));
  }

//ordr image change
  void onOrderImageChange(XFile? image) {
    emit(state.copyWith(orderImage: image));
  }

  // Save customer
  void saveCustomer() {
    final customerForm = state.customerForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    if (state.isEditing) {
      _customerRepository.updateUser(customerForm).then((_) {
        //get customers after updating
        getCustomers();
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            isEditing: false,
            selectedCustomer: null,
            customerForm: UserModel.empty,
            successMessage: "Customer updated successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
    } else {
      _customerRepository.addUser(customerForm).then((_) {
        //get customers after saving
        getCustomers();
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            isEditing: false,
            selectedCustomer: null,
            customerForm: UserModel.empty,
            successMessage: "Customer saved successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
    }
  }

  // Save order
  void saveOrder() {
    final orderForm = state.orderForm;

    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    if (state.isEditing) {
      _ordersRepository.updateOrder(orderForm, state.orderImage).then((_) {
        //get orders after updating
        getOrders();
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            isEditing: false,
            selectedOrder: null,
            orderForm: CustomerOrder.empty,
            successMessage: "Order updated successfully"));
        resetFormStatus();
      }).catchError((error) {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: error.toString()));
        resetFormStatus();
      });
    } else {
      //get current date in string
      final date = DateTime.now().toIso8601String();

      _ordersRepository
          .addOrder(orderForm.copyWith(createdAt: date), state.orderImage)
          .then((_) {
        //get orders after saving
        getOrders();
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            isEditing: false,
            selectedOrder: null,
            orderForm: CustomerOrder.empty,
            successMessage: "Order saved successfully"));
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

  void editOrder(CustomerOrder order) {
    emit(state.copyWith(
      orderForm: order,
      isEditing: true,
      selectedOrder: order,
    ));
  }

  // Set selected customer
  void setSelectedCustomer(UserModel customer) {
    emit(state.copyWith(
      selectedCustomer: customer,
      customerForm: customer,
    ));
  }

  // Set selected order
  void setSelectedOrder(CustomerOrder order) {
    emit(state.copyWith(
      selectedOrder: order,
      orderForm: order,
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

  // Get all orders
  void getOrders() {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _ordersRepository.getOrders().then((orders) {
      emit(state.copyWith(
          orders: orders, pageStatus: FormzSubmissionStatus.success));
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

  // Delete customer
  void deleteCustomer(UserModel customer) {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _customerRepository.deleteUser(customer).then((_) {
      //get customers after deleting
      getCustomers();
      emit(state.copyWith(
          pageStatus: FormzSubmissionStatus.success,
          customerForm: UserModel.empty,
          isEditing: false,
          selectedCustomer: null,
          successMessage: "Customer deleted successfully"));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  // Delete order
  void deleteOrder(CustomerOrder order) {
    emit(state.copyWith(pageStatus: FormzSubmissionStatus.inProgress));

    _ordersRepository.removeOrder(order).then((_) {
      //get orders after deleting
      getOrders();
      emit(state.copyWith(
          pageStatus: FormzSubmissionStatus.success,
          orderForm: CustomerOrder.empty,
          isEditing: false,
          selectedOrder: null,
          successMessage: "Order deleted successfully"));
    }).catchError((error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          pageStatus: FormzSubmissionStatus.failure));
    });
  }

  //clearForm
  void clearForm() {
    emit(state.copyWith(
      customerForm: UserModel.empty,
      isEditing: false,
      selectedCustomer: null,
    ));
  }

  //clearOrderForm
  void clearOrderForm() {
    emit(state.copyWith(
      orderForm: CustomerOrder.empty,
      isEditing: false,
      selectedOrder: null,
    ));
  }
}
