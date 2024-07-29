import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authenticationRepository}) : super(SignUpState());

  final AuthenticationRepository authenticationRepository;

  void onFormChange(String field, dynamic value) {
    log("field: $field, value: $value");
    final updatedUser = state.userForm.copyWithField(field, value);

    final isValid = checkFormValid(
      updatedUser.email?.value ?? "",
      updatedUser.password?.value ?? "",
      updatedUser.confirmPassword?.value ?? "",
    );

    print("isValid: $isValid");

    emit(state.copyWith(
      userForm: updatedUser,
      isFormValid: isValid,
    ));
  }

  // Save user
  Future<void> saveUser() async {
    final userForm = state.userForm;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    try {
      // Call the signUp method from the authentication repository
      await authenticationRepository.signUp(user: userForm);
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.success,
        successMessage: "User registered successfully",
      ));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
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
      userForm: UserModel.empty,
      formStatus: FormzSubmissionStatus.initial,
      successMessage: null,
      errorMessage: null,
      isFormValid: false,
    ));
  }

  //check if form is valid chec
  bool checkFormValid(String email, String password, String confirmPAssword) {
    //check email
    final newEmail = Email.dirty(email);
    final newPass = Password.dirty(password);
    final newConfirmPass = Password.dirty(confirmPAssword);

    //check if form is valid
    return newEmail.isValid && newPass.isValid && newConfirmPass.isValid;
  }
}
