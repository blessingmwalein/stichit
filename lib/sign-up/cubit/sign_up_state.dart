part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  SignUpState({
    this.formStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
    this.successMessage,
    UserModel? userForm,
  }) : userForm = userForm ?? UserModel.empty;

  final FormzSubmissionStatus formStatus;
  final bool isFormValid;
  final String? errorMessage;
  final String? successMessage;
  final UserModel userForm;

  SignUpState copyWith({
    FormzSubmissionStatus? formStatus,
    bool? isFormValid,
    String? errorMessage,
    String? successMessage,
    UserModel? userForm,
  }) {
    return SignUpState(
      formStatus: formStatus ?? this.formStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      userForm: userForm ?? this.userForm,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        isFormValid,
        errorMessage,
        successMessage,
        userForm,
      ];
}
