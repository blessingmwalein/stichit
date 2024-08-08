import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:stichit/sign-up/models/auth_request.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationRepository}) : super(LoginState());

  final AuthenticationRepository authenticationRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedAuthRequest = state.authRequest.copyWithField(field, value);

    final isValid = checkFormValid(
      updatedAuthRequest.email.value,
      updatedAuthRequest.password.value,
    );

    print("isValid: $isValid");

    emit(state.copyWith(
      authRequest: updatedAuthRequest,
      isFormValid: isValid,
    ));
  }

  // Log in user
  Future<void> loginUser() async {
    final authRequest = state.authRequest;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    try {
      // Call the logIn method from the authentication repository
      await authenticationRepository.logInWithEmailAndPassword(
          email: authRequest.email.value, password: authRequest.password.value);
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.success,
        successMessage: "User logged in successfully",
      ));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          formStatus: FormzSubmissionStatus.failure,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  // Clear form
  void clearForm() {
    emit(state.copyWith(
      authRequest:
          const AuthRequest(email: Email.pure(), password: Password.pure()),
      formStatus: FormzSubmissionStatus.initial,
      successMessage: null,
      errorMessage: null,
      isFormValid: false,
    ));
  }

  // Check if form is valid
  bool checkFormValid(String email, String password) {
    final newEmail = Email.dirty(email);
    final newPass = Password.dirty(password);

    // Check if form is valid
    return newEmail.isValid && newPass.isValid;
  }
}
